#!/usr/bin/ruby
require "ftools"
require "date"

iChatLogsDir = "~/Documents/iChats"
Dir.chdir(File.expand_path(iChatLogsDir))
Dir.new(File.expand_path(iChatLogsDir)).each {
  |x| 
    if File.ftype(x) != "directory"
      if /([12][09]\d\d-[01]\d-[0123]\d)/.match(x)
        File.makedirs $1
        File.move(x, $1)
      end
    end
}
puts "Dated logs finished."
Dir.new(File.expand_path(iChatLogsDir)).each {
  |y|
    if File.ftype(y) != "directory" 
      kMDcreationString = `/usr/bin/mdls -name kMDItemFSCreationDate "#{File.expand_path(y)}"`
      creationDate = Date.parse(kMDcreationString)
      File.makedirs creationDate.to_s
      File.move(y, creationDate.to_s)
    end
}
puts "Numbered logs finished."
puts "Logs are now organized."