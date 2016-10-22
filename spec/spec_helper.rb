# frozen_string_literal: true
require 'simplecov'
# Fix

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

require_relative '../lib/meetup_api.rb'
require_relative '../lib/location.rb'
require_relative '../lib/city.rb'
require_relative '../lib/event.rb'
require_relative '../lib/group.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes/'
CASSETTE_FILE = 'meetup_api_cassette'
