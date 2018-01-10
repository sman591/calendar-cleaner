require_relative './calendar_cleaner/api'
require_relative './calendar_cleaner/rules/rules'

module CalendarCleaner
  def self.run(options)
    api = Api.new(options)

    rules = [
      CalendarCleaner::Rules::Logging.new,
      CalendarCleaner::Rules::Timezones.new,
      CalendarCleaner::Rules::ShortenName.new,
      CalendarCleaner::Rules::Location.new,
      CalendarCleaner::Rules::MoveDay.new,
    ]

    puts 'Upcoming events:'
    puts 'No upcoming events found' if api.items.empty?
    api.items.each do |event|
      mutated = false
      rules.each do |rule|
        mutated = true if rule.process_event(event)
      end
      api.update_event(event) if mutated
    end
  end
end
