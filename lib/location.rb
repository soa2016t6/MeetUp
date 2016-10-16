# module comment
module Meetup
  # Location class, having long and lat
  class Location
    attr_accessor :lon
    attr_accessor :lat

    def initialize(lat, lon)
      @lon = lon
      @lat = lat
    end
  end
end
