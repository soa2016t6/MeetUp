require_relative 'meetup_api'
require_relative 'location'

module Meetup
  # Class to set up a Meetup Group
  class Group
    attr_reader :name
    attr_reader :urlname
    attr_reader :city

    def initialize(name, urlname, city)
      @name = name
      @urlname = urlname
      @city = city
    end
  end

  # Class to extract the located groups from meetup
  class LocatedGroups
    attr_reader :groups

    def initialize(meetup_api, country_code, location_raw_text)
      @meetup_api = meetup_api
      raw_groups = @meetup_api.get_groups(country_code, location_raw_text)
      @groups = raw_groups.map do |g|
        Meetup::Group.new(
          name: g['name'], urlname: g['urlname'], city: g['city'],
          location: Meetup::Location.new(g['lat'], g['lon'])
        )
      end
    end
  end
end
