# frozen_string_literal: true
require_relative 'meetupevents'
require_relative 'location'
require 'concurrent'

module Meetup
  # Class to set up a Meetup Event
  class Event
    attr_reader :name, :status, :city, :venue,
                :time, :location, :url, :topic, :description

    def initialize(name:, status:, city:, venue:, time:,
                   location:, url:, topic:, description:)
      @name = name
      @status = status
      @city = city
      @time = time
      @venue = venue
      @location = location
      @url = url
      @topic = topic
      @description = description
    end
  end

  # Class to extract the located events from meetup
  class LocatedEvents
    attr_reader :events
    def get_event_location(e)
      if e['venue']
        Meetup::Location.new(e['venue']['lat'],
                             e['venue']['lon'])
      else
        Meetup::Location.new(e['group']['group_lat'],
                             e['group']['group_lon'])
      end
    end
    # TOO SLOW
    # def get_event_category(g)
    #   print g['group']['urlname']
    #   groupurl = g['group']['urlname'] #.encode(Encoding.find('ASCII'))
    #   g = Meetup::MeetupApi.find_group_by_url(groupurl)
    #   g['category'] ? g['category']['short_name'] : 'None'
    # end

    def initialize(country:, city:, topic: 'none')
      raw_events = MeetupApi.get_events_city(country, city, topic)
      @events = raw_events.map do |g|
        Concurrent::Promise.execute {
          Meetup::Event.new(name: g['name'], status: g['status'],
                            city: city,
                            description: g['description'],
                            venue: g['venue'] ? g['venue']['name'] : '', # may nil
                            time: g['time'], location: get_event_location(g),
                            url: g['event_url'], topic: topic)
        }
      end
    end
  end
end
