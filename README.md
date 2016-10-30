# MeetUp
meetup_api is a gem that specializes in getting data from Meetup Groups, cities and events.

## Installation

If you are working on a project, add this to your Gemfile: `gem 'meetup_api'`

For ad hoc installation from command line:

```$ gem install meetup_api```

## Setup Credentials

Please setup your Meetup developer account, and get an API key from https://secure.meetup.com/meetup_api/key/

## Usage

Require meetup_api gem in your code: `require 'meetup_api'`

Supply your Facebook credentials to our library in one of two ways:
- Setup environment variables: `ENV['MEETUP_API_KEY']`
- or, provide them directly to meetup_api:

```
Meetup::MeetupApi.config = { access_key: ENV['MEETUP_API_KEY'] }
```

See the following example code for more usage details:

```
WIP
```
