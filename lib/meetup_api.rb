require 'http'
require 'yaml'
module Meetup
  # Meetup api
  class MeetupApi
    API_URL = 'https://api.meetup.com/'.freeze
    API_VERSION = '2'.freeze
    LOG_LOCATION = '../spec/fixtures/'.freeze
    VERSIONED_API_URL = URI.join(API_URL, "#{API_VERSION}/")
    CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))

    def initialize
      @access_key = CREDENTIALS['api_key']
    end

    def get_cities(country_code)
      api_url = URI.join(VERSIONED_API_URL, '/cities/')
      puts api_url
      cities_response = HTTP.get(api_url,
                                 params: { country: country_code,
                                           signed: true,
                                           key: @access_key })
      response = JSON.parse(cities_response.to_s)
      add_log(response, "cities_#{country_code}")
    end

    def get_events(lon, lat)
      api_url = URI.join(API_URL, '/find/events/')
      events_response = response HTTP.get(api_url,
                                          params: { lon: lon,
                                                    lat: lat,
                                                    signed: true,
                                                    key: @access_key })
      response = JSON.parse(events_response.to_s)
      puts response
    end

    def add_log(response, filename)
      filepath = "#{LOG_LOCATION} #{filename}.txt"
      File.open(filepath, 'w+') { |file| file.write(response) }
    end
  end
end
