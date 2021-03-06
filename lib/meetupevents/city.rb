# frozen_string_literal: true
require_relative 'meetupevents'
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
    attr_reader :topic

    def initialize(name:, location:, country:, topic: 'none')
      @name = name
      @location = location
      @country = country
      @topic = topic
    end

    def groups
      return @groups if @groups
      located_groups = Meetup::LocatedGroups.new(country: @country,
                                                 location_raw_text: @name)
      @groups = located_groups.groups
    end

    def events
      return @events if @events
      located_events = Meetup::LocatedEvents.new(city: @name,
                                                 country: @country,
                                                 topic: @topic)
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
