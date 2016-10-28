# for now, you must be in the MeetUp/spec directory
# otherwise the commands 'rake tests:spec' and 'rake tests:wipe' will fail
require YAML

namespace :tests do
  desc 'run tests'
  task :spec do
    sh 'ruby spec/meetup_api_spec.rb'
  end

  desc 'delete cassette fixtures'
  task :wipe do
    sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
      puts(ok ? 'Cassettes deleted' : 'No casseettes found')
    end
  end
end

namespace :credentials do
  require 'yaml'

  desc 'generate api_key to STDOUT'
  task :get_api_key do
    credentials = YAML.load(File.read('config/credentials.yml'))
    require_relative 'lib/MeetUp/meetup_api'
    ENV['MeetUP_Key'] = credentials[:api_key]
    puts "Access Token: #{MeetupApi:meetup_api.access_token}"
  end

  desc 'Export sample credentials from file to bash'
  task :export do
    credentials = YAML.load(File.read('config/credentials.yml'))
    puts 'Please run the following in bash:'
    puts "export MeetUP_Key=#{credentials[:api_key]}"
  end
end

namespace :quality do
  desc 'run all quality checks'
  task all: [:flog, :flay, :rubocop]

  task :flog do
    sh 'flog lib/'
  end

  task :flay do
    sh 'flay lib/'
  end

  task :rubocop do
    sh 'rubocop'
  end
end

namespace :api do
  # nothing for now
end
