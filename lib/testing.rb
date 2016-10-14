require_relative 'meetup_api'
@meetup_api = Meetup::MeetupApi.new
cities = @meetup_api.get_cities('tw')['results']
c = cities[0]

events = @meetup_api.get_events(c['city'], c['lat'], c['lon'])
puts events
