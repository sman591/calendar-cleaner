module CalendarCleaner::Rules
  class Location < AbstractRule
    def process_event(event)
      matches = event.location&.match(/.+\((...)\)\s?-\s?(.+)/)
      return unless matches.present?
      puts ' --> Shortening location'
      event.location = "#{matches[1]} #{matches[2]}"
      true
    end
  end
end
