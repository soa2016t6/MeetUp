require 'http'

def getlocation
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
events_around
