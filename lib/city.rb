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

    def initialize(meetup_api, name, location, country)
      @meetup_api = meetup_api
      @name = name
      @location = location
      @country = country
    end

    def groups
      return @groups if @groups
      located_groups = Meetup::LocatedGroups.new(@meetup_api, @country, @name)
      @groups = located_groups.groups
    end

    def events
      return @events if @events
      located_events = Meetup::LocatedEvents.new(@meetup_api, @counry, @location)
      @events = located_events.events
    end
  end
end