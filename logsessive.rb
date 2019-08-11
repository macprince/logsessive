#!/usr/bin/env ruby
require "ftools"
require "time"

start = Time.now()

iChatLogsDir = File.expand_path("~/Documents/iChats")

def moveLog(filename, dir)
  if !File.exist?(dir)
    File.makedirs dir
  end
  File.move(filename, dir)
end

Dir.chdir(iChatLogsDir)
Dir.new(iChatLogsDir).each {
  |log| 
      if log.to_s.match(/chat$/)
        puts log
        /([12][09]\d\d-[01]\d-[0123]\d)/.match(log)
        moveLog(log, $1)
      end
}
puts "Dated logs finished."

Dir.new(iChatLogsDir).each {
  |log|
      if log.to_s.match(/chat$/)
        /([12][09]\d\d-[01]\d-[0123]\d)/.match(`/usr/bin/mdls -name kMDItemFSCreationDate "#{File.expand_path(log)}"`)
        moveLog(log, $1)
      end
}
timediff = Time.now() - start

puts "Numbered logs finished."
puts "iChat logs are now organized."
puts "Completed in #{timediff} seconds."