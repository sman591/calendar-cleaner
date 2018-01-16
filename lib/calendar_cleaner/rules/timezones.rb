# frozen_string_literal: true

module CalendarCleaner::Rules
  class Timezones < AbstractRule
    def process_event(event)
      return unless event&.start&.time_zone.nil? &&
                    event&.start&.date_time.present? &&
                    event&.end&.date_time.present? &&
                    event.recurring_event_id.blank?
      puts ' --> Moving event up 3 hours and setting America/New_York timezone'
      [event.start, event.end].each do |piece|
        piece.date_time -= 3.hours
        piece.time_zone = 'America/New_York'
      end
      true
    end
  end
end
