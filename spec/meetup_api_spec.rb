# frozen_string_literal: true
require_relative 'spec_helper'

describe 'MeetUp Api tests' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<API_KEY>') do
      URI.unescape(ENV['MeetUP_Key'])
    end

    c.filter_sensitive_data('<API_KEY>') do
      URI.escape(ENV['MeetUP_Key'])
    end
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes

    @meetup_api = Meetup::MeetupApi.new(CREDENTIALS)
    cities = @meetup_api.get_cities('tw')
    c = cities[0]
    @city = c
    @cities = cities
  end

  after do
    VCR.eject_cassette
  end

  it 'should get cities data from api"' do
    @cities.length.must_be :>, 0
  end

  it 'should save the results of get_cities to "cities_country_code.yml"' do
    cities_output = YAML.load(File.read('spec/fixtures/cities_tw.yml'))
    # the following checks if data country_code is Taiwan
    cities_output.first[1].first['country'].must_equal 'tw'
    # cities_output.wont_be_nil
    # cities_output.count { |line| line =~ /members:/ }.must_be.>=1
  end

  it 'should load the events from a city' do
    c_location = Meetup::Location.new(@city['lat'], @city['lon'])
    city_object = Meetup::City.new(@meetup_api,
                                   name: @city['city'],
                                   location: c_location,
                                   country: @city['country'])
    city_object.events.length.must_be :>, 0
  end

  it 'should load the groups from a city' do
    c_location = Meetup::Location.new(@city['lat'], @city['lon'])
    city_object = Meetup::City.new(@meetup_api,
                                   name: @city['city'],
                                   location: c_location,
                                   country: @city['country'])
    city_object.groups.length.must_be :>, 0
  end

  it 'should save the results of get_events to "events City.yml"' do
    events_output = YAML.load(File.read("spec/fixtures/events_at_#{@city['city']}.yml"))
    # the following checks if 'created' attribute of the events data isnt nil
    events_output.first['created'].wont_be_nil
    # events_output.size.wont_be_nil
    # events_output.count { |line| line =~ /duration:/ }.must_be.>=1
  end

  it 'should save the results of get_groups to "cities country_code.yml"' do
    groups_output = YAML.load(File.read("spec/fixtures/groups_at_#{@city['city']}.yml"))
    # the following checks if groups data are from Taiwan
    # because Taipei City is in Taiwan
    groups_output.first['country'].must_equal 'TW'
    # groups_output.wont_be_nil
    # groups_output.count { |line| line =~ /description:/ }.must_be.>=1
  end

  it 'should find a single city by id' do
    info = Meetup::City.find(@meetup_api, id: '94101')
    info.name.must_equal('San Francisco')
  end

  it 'should find a single group by id' do
    info = Meetup::Group.find(@meetup_api, urlname: 'Hiking-and-Riding-in-Taipei')
    info.name.must_equal('Hiking and Riding in Taipei')
  end

  describe 'MeetUp Credentials' do
    it 'should be able to get a new access token with ENV credentials' do
      Meetup::MeetupApi.config.length.must_be :>, 0
    end

    it 'should be able to get a new access token with file credentials' do
      Meetup::MeetupApi.config = { api_key: ENV['MeetUP_Key'] }
      Meetup::MeetupApi.config.length.must_be :>, 0
    end
  end
end
