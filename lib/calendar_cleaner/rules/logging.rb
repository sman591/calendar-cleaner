# frozen_string_literal: true

module CalendarCleaner::Rules
  class Logging < AbstractRule
    def process_event(event)
      start = event.start.date || event.start.date_time
      puts "- #{event.summary} (#{start})"
      false
    end
  end
end
