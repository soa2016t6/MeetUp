require 'http'

module Meetup
  class MeetupApi
    API_URL = 'https://api.meetup.com/'
    API_VERSION = '2'
    MEETUP_API_URL = URI.join(FB_URL, "#{API_VER}/")

    def get_cities(country_code)
      api_url = URI.join(MEETUP_API_URL, "/cities/")
      #cities_response = HTTP.get(api_url)
      JSON.load(cities_response.to_s)
    end

    def get_groupevents(location)
      api_url = URI.join(API_URL, "/find/groups/")
      #groups =_response HTTP.get(api_url)
      JSON.load(_response.to_s)
    end

    def getgroup
      lat = 24.8154
      lon = 120.9672
      return lat, lon
    end

    def events_around
      lat = 24.8154
      lon = 120.9672
      response = HTTP.get('https://api.meetup.com/2/cities?&sign=true&photo-host=public&lon=#{lon}&radius=20&lat=#{lat}&page=20').read
      puts response
    end

    def addlog(tolog)
      open('log.txt', 'a') { |f|
        f.puts tolog
      }
    end

  end
end
