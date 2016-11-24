# frozen_string_literal: true
require 'http'
require 'cgi'
module Meetup
  # Meetup api
  class MeetupApi
    API_URL = 'https://api.meetup.com'
    API_VERSION = '2'
    LOG_LOCATION = 'spec/fixtures/'
    VERSIONED_API_URL = URI.join(API_URL, API_VERSION.to_s)
    # Grabs the api ket from config file inside the config directory

    def self.access_key
      return @access_key if @access_key
      if ENV['MEETUP_API_KEY'].nil?
        puts 'MEETUP_API_KEY environment variable not found! Please define it.'
      else
        @access_key = ENV['MEETUP_API_KEY']
      end
    end

    def self.config=(credentials)
      @config ? @config.update(credentials) : @config = credentials
    end

    def self.config
      return @config if @config
      @config = { access_key: ENV['MEETUP_API_KEY'] }
    end

    # Gets cities based on country code (ex. tw)
    def self.get_cities(country_code)
      api_url = URI.join(VERSIONED_API_URL, '/cities/')
      cities_response = HTTP.get(api_url,
                                 params: { country: country_code,
                                           signed: true,
                                           key: access_key })
      response = JSON.parse(cities_response.to_s)
      # add_log(response, "cities_#{country_code}")
      response['results']
    end

    def self.cities_info(id)
      api_url = URI.join(API_URL, "/#{API_VERSION}/", 'cities')
      escaped_id = "id+=+#{id}"
      cities2_response = HTTP.get(api_url,
                                  params: { query: URI.encode(escaped_id),
                                            signed: true,
                                            key: access_key })
      response = JSON.parse(cities2_response.to_s)
      # add_log(response, "city_id_#{id}")
      response['results']
    end

    # Get all cities of a country
    def self.get_cities_by_country(country)
      api_url = URI.join(API_URL, "/#{API_VERSION}/", 'cities')
      cities_response = HTTP.get(api_url,
                                 params: { country: country,
                                           signed: true,
                                           key: access_key })
      response = JSON.parse(cities_response.to_s)
      # add_log(response, "events_at_#{place}")
      response
    end

    # Gets events based on the location. Place var just for fixtures
    def self.get_events_location(lat, lon)
      api_url = URI.join(API_URL, '/find/events/')
      events_response = HTTP.get(api_url,
                                 params: { lon: lon,
                                           lat: lat,
                                           signed: true,
                                           key: access_key })
      response = JSON.parse(events_response.to_s)
      # add_log(response, "events_at_#{place}")
      response
    end

    def self.get_events_city(country, city, topic)
      params = { country: country,
                 city: city,
                 topic: topic,
                 signed: true,
                 key: access_key }
      params.tap{ |h| h.delete(:topic) } unless topic != 'none'
      api_url = URI.join(API_URL, "/#{API_VERSION}/", 'open_events')
      events_response = HTTP.get(api_url,
                                 params: params)
      response = JSON.parse(events_response.to_s)
      # add_log(response, "events_at_#{place}")
      response['results']
    end

    # Finds groups based on a location text query
    def self.get_groups(country_code, location_raw_text)
      api_url = URI.join(API_URL, '/find/groups')
      groups_response = HTTP.get(api_url,
                                 params: { country: country_code,
                                           fallback_suggestions: 'true',
                                           location: location_raw_text,
                                           key: access_key })
      response = JSON.parse(groups_response.to_s)
      # add_log(response, "groups_at_#{location_raw_text}")
      response
    end

    # Finds groups based on a location text query
    def self.find_group_by_url(urlname)
      urlname = CGI.escape(urlname)
      api_url = URI.join(API_URL, "/#{urlname}")
      groups_response = HTTP.get(api_url,
                                 params: { signed: true,
                                           key: access_key })
      response = JSON.parse(groups_response.to_s)
      # add_log(response, "group_with_url_#{urlname}")
      response
    end
    private_class_method

    # def self.add_log(response, filename)
    #   filepath = "#{LOG_LOCATION}#{filename}.yml"
    #   File.open(filepath, 'w') { |file| file.write(response.to_yaml) }
    # end
  end
end
