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

require_relative '../lib/meetupevents'

if File.file?('config/credentials.yml')
  credentials = YAML.load(File.read('config/credentials.yml'))
  ENV['MEETUP_API_KEY'] = credentials.first['api_key']
end

# CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes/'
CASSETTE_FILE = 'meetup_api_cassette'

# set MEETUP_API_KEY environment variable
# ENV['MEETUP_API_KEY'] = CREDENTIALS.first['api_key']
