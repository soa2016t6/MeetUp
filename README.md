# MeetUp
[![Build Status](https://travis-ci.org/soa2016t6/MeetUp.svg?branch=master)](https://travis-ci.org/soa2016t6/MeetUp)
[![Gem Version](https://badge.fury.io/rb/meetupevents.svg)](https://badge.fury.io/rb/meetupevents)

meetup_api is a gem that specializes in getting data from Meetup Groups, cities and events.

## Installation

If you are working on a project, add this to your Gemfile: `gem 'meetupevents'`

For ad hoc installation from command line:

```$ gem install meetupevents``` (SOON)

## Setup Credentials

Please setup your Meetup developer account, and get an API key from https://secure.meetup.com/meetup_api/key/

## Usage

Require meetupevents gem in your code: `require 'meetupevents'`

Supply your Meetup credentials to our library in one of two ways:
- Setup environment variables: `ENV['MEETUP_API_KEY']`
- or, provide them directly to meetup_api:

```
Meetup::MeetupApi.config = { access_key: ENV['MEETUP_API_KEY'] }
```

See the following example code for more usage details:

```
WIP
```
