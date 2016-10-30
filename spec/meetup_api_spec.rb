# frozen_string_literal: true
require_relative 'spec_helper'

describe 'MeetUp Api tests' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<API_KEY>') do
      ENV['MEETUP_API_KEY']
    end
    c.filter_sensitive_data('<API_KEY>') do
      URI.escape(ENV['MEETUP_API_KEY'])
    end
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
    cities = Meetup::MeetupApi.get_cities('tw')
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

  it 'should load the events from a city' do
    c_location = Meetup::Location.new(@city['lat'], @city['lon'])
    city_object = Meetup::City.new(name: @city['city'],
                                   location: c_location,
                                   country: @city['country'])
    city_object.events.length.must_be :>, 0
  end

  it 'should load the groups from a city' do
    c_location = Meetup::Location.new(@city['lat'], @city['lon'])
    city_object = Meetup::City.new(name: @city['city'],
                                   location: c_location,
                                   country: @city['country'])
    city_object.groups.length.must_be :>, 0
  end

  it 'should find a single city by id' do
    info = Meetup::City.find(id: '94101')
    info.name.must_equal('San Francisco')
  end

  it 'should find a single group by id' do
    info = Meetup::Group.find(urlname: 'Hiking-and-Riding-in-Taipei')
    info.name.must_equal('Hiking and Riding in Taipei')
  end
end
