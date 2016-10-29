# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'meetup_api/version'

Gem::Specification.new do |s|
  s.name        =  'meetup_api'
  s.version     =  Meetup::VERSION

  s.summary     =  'Gets events and groups content from Meetup'
  s.description =  'Extracts events, groups, and cities from Meetup'
  s.authors     =  ['Isaac Martinez, Fabio Daio, Roverto Yebra']
  s.email       =  ['soumya.ray@gmail.com']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")
  s.executables << 'meetup_api'

  s.add_runtime_dependency 'http', '~> 2.0'

  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'flog', '~> 4.4'
  s.add_development_dependency 'flay', '~> 2.8'
  s.add_development_dependency 'rubocop', '~> 0.42'
  s.homepage    =  'https://github.com/soa2016t6/MeetUp'
  s.license     =  'MIT'
end
