# frozen_string_literal: true

module CalendarCleaner::Rules
  class MoveDay < AbstractRule
    MONDAY = 1

    def process_event(event)
      return unless event&.start&.date_time&.wday == MONDAY && event.summary == 'Wines of the World'
      event.start.date_time += 2.days
      event.end.date_time += 2.days
      true
    end
  end
end
