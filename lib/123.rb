
require_relative 'meetup_api'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))

@meetup_api = Meetup::MeetupApi.new
cities = @meetup_api.get_cities('tw')['results']
c = cities[0]
@meetup_api.get_events(c['city'], c['lat'], c['lon'])
events_output = YAML.load(File.read('spec/fixtures/events_Taipei.yml'))
events_output.count { |line| line =~ /duration:/ }.must_be.>=1
