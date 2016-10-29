# frozen_string_literal: true
require 'simplecov'
# Fi

SimpleCov.configure do
  @filters = []
end
SimpleCov.start
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'
require 'http'

require_relative '../lib/meetup_api/meetup_api.rb'
require_relative '../lib/meetup_api/location.rb'
require_relative '../lib/meetup_api/city.rb'
require_relative '../lib/meetup_api/event.rb'
require_relative '../lib/meetup_api/group.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes/'
CASSETTE_FILE = 'meetup_api_cassette'

#set MEETUP_API_KEY environment variable
ENV['MEETUP_API_KEY'] = CREDENTIALS.first['api_key']
