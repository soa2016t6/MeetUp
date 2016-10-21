require 'http'
require 'yaml'
module Meetup
  # Meetup api
  class MeetupApi
    API_URL = 'https://api.meetup.com/'.freeze
    API_VERSION = '2'.freeze
    LOG_LOCATION = 'spec/fixtures/'.freeze # m
    VERSIONED_API_URL = URI.join(API_URL, "#{API_VERSION}/")

    # Grabs the api ket from config file inside the config directory
    def initialize(credentials)
      @access_key = credentials.first['api_key']
    end

    # Gets cities based on country code (ex. tw)
    def get_cities(country_code)
      api_url = URI.join(VERSIONED_API_URL, '/cities/')
      cities_response = HTTP.get(api_url,
                                 params: { country: country_code,
                                           signed: true,
                                           key: @access_key })
      response = JSON.parse(cities_response.to_s)
      add_log(response, "cities_#{country_code}")
      response['results']
    end

    # Gets events based on the location. Place var just for fixtures
    def get_events(place, lat, lon)
      api_url = URI.join(API_URL, '/find/events/')
      events_response = HTTP.get(api_url,
                                 params: { lon: lon,
                                           lat: lat,
                                           signed: true,
                                           key: @access_key })
      response = JSON.parse(events_response.to_s)
      add_log(response, "events_at_#{place}")
      response
    end

    # Finds groups based on a location text query
    def get_groups(country_code, location_raw_text)
      api_url = URI.join(API_URL, '/find/groups')
      groups_response = HTTP.get(api_url,
                                 params: { country: country_code,
                                           fallback_suggestions: 'true',
                                           location: location_raw_text,
                                           key: @access_key })
      response = JSON.parse(groups_response.to_s)
      add_log(response, "groups_at_#{location_raw_text}")
      response
    end

    def add_log(response, filename)
      filepath = "#{LOG_LOCATION}#{filename}.yml"
      File.open(filepath, 'w') { |file| file.write(response.to_yaml) }
    end
  end
end
