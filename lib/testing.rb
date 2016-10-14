require_relative 'meetup_api'
@meetup_api = Meetup::MeetupApi.new
@meetup_api.get_cities('tw')
