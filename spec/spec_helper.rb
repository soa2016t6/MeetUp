require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require '../lib/meetup_api.rb'
require '../lib/location.rb'
require '../lib/city.rb'
require '../lib/event.rb'
require '../lib/group.rb'

CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
