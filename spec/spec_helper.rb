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

require_relative '../lib/MeetUp/meetup_api.rb'
require_relative '../lib/MeetUp/location.rb'
require_relative '../lib/MeetUp/city.rb'
require_relative '../lib/MeetUp/event.rb'
require_relative '../lib/MeetUp/group.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes/'
CASSETTE_FILE = 'meetup_api_cassette'

if File.file?('config/credentials.yml')
  credentials = YAML.load(File.read('config/credentials.yml'))
  ENV['MeetUP_Key'] = credentials[:api_key]
end
