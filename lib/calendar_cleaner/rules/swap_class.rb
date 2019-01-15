# frozen_string_literal: true

module CalendarCleaner::Rules
  class SwapClass < AbstractRule
    OLD_NAME = 'Big Data Analytics'
    OLD_INSTRUCTOR = 'Thomas Kinsman'
    NEW_NAME = 'Web Services'
    NEW_LOCATION = 'GOL 3560'
    NEW_INSTRUCTOR = 'Xumin Liu'

    def process_event(event)
      return unless event.summary.include?(OLD_NAME)
      puts " --> Replacing \"#{OLD_NAME}\" class for \"#{NEW_NAME}\" at #{NEW_LOCATION}"
      event.summary.sub!(OLD_NAME, NEW_NAME)
      event.summary.sub!(OLD_NAME, NEW_NAME)
      event.description.sub!(OLD_INSTRUCTOR, NEW_INSTRUCTOR)
      event.location = NEW_LOCATION
      true
    end
  end
end
