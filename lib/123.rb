
require_relative 'meetup_api'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))

@meetup_api = Meetup::MeetupApi.new(CREDENTIALS)
cities = @meetup_api.get_cities('tw')['results']
c = cities[0]
puts c
@meetup_api.get_events(c['city'], c['lat'], c['lon'])
