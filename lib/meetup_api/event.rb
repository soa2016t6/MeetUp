# frozen_string_literal: true
require_relative 'meetup_api'
require_relative 'location'

module Meetup
  # Class to set up a Meetup Event
  class Event
    attr_reader :name, :status, :city, :venue, :time, :location

    def initialize(name:, status:, city:, venue:, time:, location:)
      @name = name
      @status = status
      @city = city
      @time = time
      @venue = venue
      @location = location
    end
  end

  # Class to extract the located events from meetup
  class LocatedEvents
    attr_reader :events

    def initialize(location:)
      raw_events = MeetupApi.get_events(location.lat,
                                        location.lon)
      @events = raw_events.map do |g|
        Meetup::Event.new(name: g['name'], status: g['status'],
                          city: g['venue'] ? g['venue']['city'] : '', # may nil
                          venue: g['venue'] ? g['venue']['name'] : '', # may nil
                          time: g['time'], location: location)
      end
    end
  end
end
