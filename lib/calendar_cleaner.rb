require_relative './calendar_cleaner/api'

module CalendarCleaner
  def self.run(options)
    api = Api.new(options)

    puts 'Upcoming events:'
    puts 'No upcoming events found' if api.items.empty?
    api.items.each do |event|
      start = event.start.date || event.start.date_time
      puts "- #{event.summary} (#{start})"
    end
  end
end
