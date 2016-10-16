# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require '../lib/meetup_api.rb'
require '../lib/location.rb'
require '../lib/city.rb'
require '../lib/event.rb'
require '../lib/group.rb'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))

describe 'MeetUp Api tests' do
  before do
    @meetup_api = Meetup::MeetupApi.new(CREDENTIALS)
    cities = @meetup_api.get_cities('tw')
    c = cities[0]
    @city = c
    @cities = cities
  end

  it 'should get cities data from api"' do
    @cities.length.must_be :>, 0
  end

  it 'should save the results of get_cities to "cities_country_code.yml"' do
    cities_output = YAML.load(File.read('fixtures/cities_tw.yml'))
    # the following checks if data country_code is Taiwan
    cities_output.first[1].first['country'].must_equal 'tw'
    # cities_output.wont_be_nil
    # cities_output.count { |line| line =~ /members:/ }.must_be.>=1
  end

  it 'should load the events from a city' do
    c_location = Meetup::Location.new(@city['lat'], @city['lon'])
    city_object = Meetup::City.new(@meetup_api,
                                   name: @city['name'],
                                   location: c_location,
                                   country: @city['country'])
    city_object.events.length.must_be :>, 0
  end

  it 'should load the groups from a city' do
    c_location = Meetup::Location.new(@city['lat'], @city['lon'])
    city_object = Meetup::City.new(@meetup_api,
                                   name: @city['name'],
                                   location: c_location,
                                   country: @city['country'])
    city_object.groups.length.must_be :>, 0
  end

  it 'should save the results of get_events to "events City.yml"' do
    events_output = YAML.load(File.read('fixtures/events_Taipei.yml'))
    # the following checks if 'created' attribute of the events data isnt nil
    events_output.first['created'].wont_be_nil
    # events_output.size.wont_be_nil
    # events_output.count { |line| line =~ /duration:/ }.must_be.>=1
  end

  it 'should save the results of get_groups to "cities country_code.yml"' do
    groups_output = YAML.load(File.read('fixtures/groups_at_Taipei City.yml'))
    # the following checks if groups data are from Taiwan
    # because Taipei City is in Taiwan
    groups_output.first['country'].must_equal 'TW'
    # groups_output.wont_be_nil
    # groups_output.count { |line| line =~ /description:/ }.must_be.>=1
  end
end
