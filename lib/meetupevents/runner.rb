module MeetUp
  # Executable code for file(s) in bin/ folder
  class Runner
    def self.run!(args)
      url_name = args[0] || ENV['MEETUP_API_KEY']
      unless url_name
        puts 'USAGE: meetupevents [url_name]'
        exit(1)
      end

      info = Meetup::Group.find(urlname: url_name)
      puts info.name
    end
  end
end
