# frozen_string_literal: true
require_relative 'meetupevents'
require_relative 'location'

module Meetup
  # Class to set up a Meetup Group
  class Group
    attr_reader :name
    attr_reader :urlname
    attr_reader :city
    attr_reader :location

    def initialize(name:, urlname:, city:, location:, country:)
      @name = name
      @urlname = urlname
      @city = city
      @location = location
      @country = country
    end

    def self.find(urlname:)
      group = MeetupApi.find_group_by_url(urlname)
      new(name: group['name'],
          city: group ['city'],
          urlname: group['urlname'],
          country: group['country'],
          location: Meetup::Location.new(group['lat'],
                                         group['lon']))
    end
  end

  # Class to extract the located groups from meetup
  class LocatedGroups
    attr_reader :groups

    def initialize(country:, location_raw_text:)
      raw_groups = MeetupApi.get_groups(country, location_raw_text)
      @groups = raw_groups.map do |g|
        Meetup::Group.new(
          name: g['name'], urlname: g['urlname'], city: g['city'],
          location: Meetup::Location.new(g['lat'], g['lon']),
          country: g['country']
        )
      end
    end
  end
end
