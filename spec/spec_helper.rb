require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'
require 'http'

require '../lib/meetup_api.rb'
require '../lib/location.rb'
require '../lib/city.rb'
require '../lib/event.rb'
require '../lib/group.rb'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
CASSETTES_FOLDER = 'fixtures/cassettes/'
CASSETTE_FILE = 'meetup_api_cassette'
