# frozen_string_literal: true
require_relative 'meetup_api'
require_relative 'location'
require_relative 'event'

require_relative 'city'
require 'yaml'
CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))

@meetup_api = Meetup::MeetupApi.new(CREDENTIALS)
cities = @meetup_api.get_cities('tw')
c = cities[0]
puts c
c_location = Meetup::Location.new(c['lat'], c['lon'])
city_object = Meetup::City.new(@meetup_api,
                               name: c['name'],
                               location: c_location,
                               country: c['country'])
puts city_object
