require 'rubygems'
require 'bundler/setup'

require './lib/calendar_cleaner'
require 'optparse'

options = {}

OptionParser.new do |parser|
  parser.on("-n", "--name NAME", "The name of the person to greet.") do |v|
    options[:name] = v
  end
end.parse!

options

# Now we can use the options hash however we like.
puts "Hello #{ options[:name] }" if options[:name]

CalendarCleaner.run
