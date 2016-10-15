# CODE: Make a library project from your earlier script
# Start a new git branch (name it api_library)
# Organize your files into folders (config, lib, spec/fixtures, etc.) and update your .gitignore
# Write a spec file to test a new Module::Class that you will create as your library
# Write your new Module::Class libraries in multiple files in lib folder, and pass your tests
# Be sure to make a git commit at this stage and merge your branch into master

require 'minitest/autorun'
require 'minitest/rg'

require_relative 'meetup_api'

@meetup_api = Meetup::MeetupApi.new
cities = @meetup_api.get_cities('tw')['results']
c = cities[0]

events = @meetup_api.get_events(c['city'], c['lat'], c['lon'])
puts events

groups = @meetup_api.get_groups('tw', 'Taipei City')
puts groups
