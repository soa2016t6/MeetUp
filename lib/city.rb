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

    def initialize(meetup_api, name:, location:, country:)
      @meetup_api = meetup_api
      @name = name
      @location = location
      @country = country
    end

    def groups
      return @groups if @groups
      located_groups = Meetup::LocatedGroups.new(@meetup_api,
                                                 country: @country,
                                                 location_raw_text: @name)
      @groups = located_groups.groups
    end

    def events
      return @events if @events
      located_events = Meetup::LocatedEvents.new(@meetup_api,
                                                 location_name: @name,
                                                 location: @location)
      @events = located_events.events
    end

    def self.find(id:)
      city_data = MeetupApi.cities_info(id)
      new(data: city_data)
    end
  end
end
