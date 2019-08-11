#!/usr/bin/ruby
require "ftools"

iChatLogsDir = "~/Documents/iChats"

def moveLog(filename, dir)
  if !File.exist?(dir)
    File.makedirs dir
  end
  File.move(filename, dir)
end

Dir.chdir(File.expand_path(iChatLogsDir))
Dir.new(File.expand_path(iChatLogsDir)).each {
  |log| 
    if File.ftype(log) != "directory"
      if /([12][09]\d\d-[01]\d-[0123]\d)/.match(log)
        moveLog(log, $1)
      end
    end
}
puts "Dated logs finished."

Dir.new(File.expand_path(iChatLogsDir)).each {
  |log|
    if File.ftype(log) != "directory" 
      /([12][09]\d\d-[01]\d-[0123]\d)/.match(`/usr/bin/mdls -name kMDItemFSCreationDate "#{File.expand_path(log)}"`)
      moveLog(log, $1)
    end
}
puts "Numbered logs finished."
puts "Logs are now organized."