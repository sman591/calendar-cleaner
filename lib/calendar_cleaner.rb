# frozen_string_literal: true

require_relative './calendar_cleaner/api'
require_relative './calendar_cleaner/rules/rules'

module CalendarCleaner
  def self.run(options)
    api = Api.new(options)

    delete_rules = [
      CalendarCleaner::Rules::Delete.new,
    ]

    update_rules = [
      CalendarCleaner::Rules::Logging.new,
      CalendarCleaner::Rules::Timezones.new,
      CalendarCleaner::Rules::ShortenName.new,
      CalendarCleaner::Rules::Location.new,
      CalendarCleaner::Rules::MoveDay.new,
      CalendarCleaner::Rules::SwapClass.new,
    ]

    puts 'Deleting events:'
    puts 'No upcoming events found' if api.items.empty?
    api.items.each do |event|
      should_delete = false
      delete_rules.each do |rule|
        should_delete = true if rule.process_event(event)
      end
      if should_delete
        puts " --> Deleting \"#{event.summary}\""
        api.delete_event(event)
      end
    end

    puts 'Updating events:'
    puts 'No upcoming events found' if api.items.empty?
    api.items.each do |event|
      mutated = false
      update_rules.each do |rule|
        mutated = true if rule.process_event(event)
      end
      api.update_event(event) if mutated
    end
  end
end
