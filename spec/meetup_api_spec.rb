
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require '../lib/meetup_api.rb'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
@meetup_api = Meetup::MeetupApi.new
cities = @meetup_api.get_cities('tw')['results']
c = cities[0]
events = @meetup_api.get_events(c['city'], c['lat'], c['lon'])
puts events
groups = @meetup_api.get_groups('tw', 'Taipei City')
puts groups

describe 'MeetUp Api tests' do
  it 'should save the results of get_cities to "cities country_code.yml"' do
    cities_output = YAML.load(File.read('fixtures/cities_tw.yml'))
    cities_output.count { |line| line =~ /members:/ }.must_be.>=1
  end

  it 'should save the results of get_events to "events City.yml"' do
    events_output = YAML.load(File.read('fixtures/events_Taipei.yml'))
    events_output.count { |line| line =~ /duration:/ }.must_be.>=1
  end

  it 'should save the results of get_groups to "cities country_code.yml"' do
    groups_output = YAML.load(File.read('fixtures/groups_at_Taipei City.yml'))
    groups_output.count { |line| line =~ /description:/ }.must_be.>=1
  end
end
