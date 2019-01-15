# frozen_string_literal: true

module CalendarCleaner::Rules
  class Delete < AbstractRule
    OLD_NAME = 'Energy and the Environment'

    def process_event(event)
      event.summary.include?(OLD_NAME)
    end
  end
end
