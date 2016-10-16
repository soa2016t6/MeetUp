require_relative 'meetup_api'
require_relative 'location'

module Meetup
  # Class to set up a Meetup Event
  class Event
    attr_reader :name, :status, :city, :venue, :time, :location

    def initialize(name, status, city, venue, time, location)
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

    def initialize(meetup_api, location_name, loc)
      @meetup_api = meetup_api
      raw_events = @meetup_api.get_events(location_name, loc.lat, loc.lon)
      @events = raw_events.map do |g|
        Meetup::Event.new(name: g['name'], status: g['status'],
                          city: g['venue']['city'],
                          venue: g['venue']['name'],
                          time: g['time'], location: loc)
      end
    end
  end
end
