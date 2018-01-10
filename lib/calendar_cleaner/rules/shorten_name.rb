module CalendarCleaner::Rules
  class ShortenName < AbstractRule
    def process_event(event)
      changed = false
      if event.summary.include?('Introduction')
        puts ' --> Abbreviating "intro"'
        event.summary.sub!('Introduction', 'Intro')
        changed = true
      end
      if event.summary.include?('Cryptography')
        puts ' --> Abbreviating "crypto"'
        event.summary.sub!('Cryptography', 'Crypto')
        changed = true
      end
      if event.summary.include?('Color Science for the Visual')
        puts ' --> Abbreviating color science'
        event.summary = 'Color Science'
        changed = true
      end
      if event.summary.include?('Professional Communications')
        puts ' --> Abbreviating Prof Comm'
        event.summary = 'Prof Comm'
        changed = true
      end
      if event.summary.include?('Engr')
        puts ' --> Fixing "engr" -> "eng"'
        event.summary.sub!('Engr', 'Eng')
        changed = true
      end
      changed
    end
  end
end
