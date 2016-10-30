# frozen_string_literal: true
require_relative 'meetup_api'
require_relative 'location'
require_relative 'group'

module Meetup
  # Class to set up a Meetup Group
  class City
    attr_reader :name
    attr_reader :location
    attr_reader :country
    attr_reader :events
    attr_reader :groups

    def initialize(name:, location:, country:)
      @name = name
      @location = location
      @country = country
    end

    def groups
      return @groups if @groups
      located_groups = Meetup::LocatedGroups.new(country: @country,
                                                 location_raw_text: @name)
      @groups = located_groups.groups
    end

    def events
      return @events if @events
      located_events = Meetup::LocatedEvents.new(location: @location)
      @events = located_events.events
    end

    def self.find(id:)
      city_data = MeetupApi.cities_info(id)[0]
      new(name: city_data['city'],
          location: Meetup::Location.new(city_data['lat'],
                                         city_data['lon']),
          country: city_data['country'])
    end
  end
end
