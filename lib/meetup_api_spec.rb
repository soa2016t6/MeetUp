
require 'minitest/autorun'
require 'minitest/rg'

require_relative 'meetup_api'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
FB_RESPONSE = YAML.load(File.read('spec/fixtures/fb_response.yml'))
RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))

describe 'MeetUp Api tests' do
  it 'should return the cities using the country_code' do
    tw
  end
  it 'should save the results of get_cities to "cities country_code.yml"' do
    cities_tw.yml
  end
  it 'should return the events using the City' do
    Taipei
  end
  it 'should save the results of get_events to "events City.yml"' do
    cities_tw.yml
  end
  it 'should return the groups using the location_raw_text' do
    TaipeiCity
  end
  it 'should save the results of get_groups to "cities country_code.yml"' do
    cities_tw.yml
  end

end

  @meetup_api = Meetup::MeetupApi.new
  cities = @meetup_api.get_cities('tw')['results']
  c = cities[0]

  events = @meetup_api.get_events(c['city'], c['lat'], c['lon'])
  puts events

  groups = @meetup_api.get_groups('tw', 'Taipei City')
  puts groups

end
