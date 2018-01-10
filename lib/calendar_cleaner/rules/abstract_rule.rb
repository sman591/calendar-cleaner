module CalendarCleaner::Rules
  class AbstractRule
    # Process an event
    # return true (or truthy) if a mutation was made, false (or falsey) if not
    def process_event(event)
      raise "process_event is required but not defined for #{self.class.name}"
    end
  end
end
