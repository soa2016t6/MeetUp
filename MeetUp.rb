require 'open-uri'

def events_around(latitude,longitude)
response = open('https://api.meetup.com/2/cities?&sign=true&photo-host=public&lon=#{longitude}&radius=20&lat=#{latitude}&page=20').read
puts response
def addlog
end

def addlog(tolog)
  open('log.txt', 'a') { |f|
    f.puts tolog
  }
end
