# frozen_string_literal: true
require 'http'
require 'yaml'
module Meetup
  # Meetup api
  class MeetupApi
    API_URL = 'https://api.meetup.com'
    API_VERSION = '2'
    LOG_LOCATION = 'spec/fixtures/'
    VERSIONED_API_URL = URI.join(API_URL, API_VERSION.to_s)
    # Grabs the api ket from config file inside the config directory
    def initialize
      if ENV['MEETUP_API_KEY'].nil?
        puts 'MEETUP_API_KEY environment variable not found! Please define it.'
      else
        @access_key = ENV['MEETUP_API_KEY']
      end
      # @access_key = credentials.first['api_key']
    end

    # Gets cities based on country code (ex. tw)
    def get_cities(country_code)
      api_url = URI.join(VERSIONED_API_URL, '/cities/')
      cities_response = HTTP.get(api_url,
                                 params: { country: country_code,
                                           signed: true,
                                           key: @access_key })
      response = JSON.parse(cities_response.to_s)
      # add_log(response, "cities_#{country_code}")
      response['results']
    end

    def cities_info(id)
      api_url = URI.join(API_URL, "/#{API_VERSION}/", 'cities')
      escaped_id = "id+=+#{id}"
      cities2_response = HTTP.get(api_url,
                                  params: { query: URI.encode(escaped_id),
                                            signed: true,
                                            key: @access_key })
      response = JSON.parse(cities2_response.to_s)
      # add_log(response, "city_id_#{id}")
      response['results']
    end

    # Gets events based on the location. Place var just for fixtures
    def get_events( lat, lon)
      api_url = URI.join(API_URL, '/find/events/')
      events_response = HTTP.get(api_url,
                                 params: { lon: lon,
                                           lat: lat,
                                           signed: true,
                                           key: @access_key })
      response = JSON.parse(events_response.to_s)
      # add_log(response, "events_at_#{place}")
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
      # add_log(response, "groups_at_#{location_raw_text}")
      response
    end

    # Finds groups based on a location text query
    def find_group_by_url(urlname)
      api_url = URI.join(API_URL, "/#{urlname}")
      groups_response = HTTP.get(api_url,
                                 params: { signed: true,
                                           key: @access_key })
      response = JSON.parse(groups_response.to_s)
      # add_log(response, "group_with_url_#{urlname}")
      response
    end

    def add_log(response, filename)
      filepath = "#{LOG_LOCATION}#{filename}.yml"
      File.open(filepath, 'w') { |file| file.write(response.to_yaml) }
    end
  end
end
