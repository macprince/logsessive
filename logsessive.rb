#!/usr/bin/env ruby
%w(ftools time).each{|rq| require rq}

numlogs = 0; datelogs = 0

start = Time.now()
iChatLogsDir = File.expand_path("~/Documents/iChats-test")

def moveLog(filename, dir)
  unless dir == nil
    if !File.exist?(dir)
      File.makedirs(dir)
    end
    File.move(filename, dir)
  end
end

Dir.chdir(iChatLogsDir)
Dir.new(iChatLogsDir).each {|log| 
   
if log.to_s.match(/chat$/)
  log.match(/([12][09]\d\d-[01]\d-[0-3]\d)/).to_s
  moveLog(log, $1)
  datelogs += 1
end
}
if datelogs > 0
  puts "#{datelogs} dated logs sorted."
else
  puts "Dated logs are already sorted."
end

Dir.new(iChatLogsDir).each {|log|
if log.to_s.match(/chat$/)
  `/usr/bin/mdls -name kMDItemFSCreationDate "#{File.expand_path(log)}"`.match(/([12][09]\d\d-[01]\d-[0-3]\d)/).to_s
  moveLog(log, $1)
  numlogs += 1
end
}
timediff = Time.now() - start

if datelogs > 0
  puts "#{numlogs} numbered logs sorted."
else
  puts "Numbered logs are already sorted."
end

if (datelogs + numlogs > 0)
  puts "iChat logs are now organized."
  puts "Completed in #{timediff} seconds."
end