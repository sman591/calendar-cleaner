require 'rubygems'
require 'bundler/setup'

require './lib/calendar_cleaner'
require 'optparse'

HOURS_24 = (60 * 60 * 24)

DEFAULT_OPTIONS = {
  calendar: 'primary',
  start: Time.now,
  end: Time.now + HOURS_24,
}.freeze

options = DEFAULT_OPTIONS.dup

OptionParser.new do |parser|
  parser.on('-c', '--calendar CALENDAR ID', 'The calendar to operate on.', 'Default: #{options[:calendar]}') do |v|
    options[:calendar] = v
  end

  parser.on('--start DATE', 'Start date of events to process', 'Default: Time.now') do |v|
    options[:start] = Date.parse(v).to_time
    if options[:end] == DEFAULT_OPTIONS[:end]
      options[:end] = options[:start] + HOURS_24
    end
  end

  parser.on('--end DATE', 'End date of events to process', 'Default: Time.now + 24 hours') do |v|
    options[:end] = Date.parse(v).to_time
  end

  parser.on('--limit NUMBER', Integer, 'Maximum number of events to process', 'Default: none') do |v|
    options[:limit] = v
  end
end.parse!

# Validate options
if options[:start] > options[:end]
  throw "Start date (#{options[:start]} cannot be after end date (#{options[:end]})"
end

# Print out the options for debugging
puts 'Options:'
puts options.inspect
puts

CalendarCleaner.run(options)
