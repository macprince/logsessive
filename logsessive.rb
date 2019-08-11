#!/usr/bin/env ruby
%w(ftools time).each{|rq| require rq}

numlogs = 0; datelogs = 0
start = Time.now()
iChat_logs_dir = File.expand_path("~/Dropbox/Chat Logs/iChats")

def move_log(filename, dir)
  unless dir == nil
    if !File.exist?(dir)
      File.makedirs(dir)
    end
    File.move(filename, dir)
  end
end

puts "Logs are being sorted.","Please be patient, as this may take a while.",""
Dir.chdir(iChat_logs_dir)
Dir.new(iChat_logs_dir).each { |log| 
  if log.to_s.match(/chat$/)
    fn_date = log.match(/([12][09]\d\d-[01]\d-[0-3]\d)/).to_s
    if fn_date != nil
      move_log(log, fn_date)
      datelogs += 1
    else
      c_date = `/usr/bin/mdls -name kMDItemFSCreationDate "#{File.expand_path(log)}"`.match(/([12][09]\d\d-[01]\d-[0-3]\d)/).to_s
      move_log(log, c_date)
      numlogs += 1
    end
  end
}
timediff = Time.now() - start

if datelogs > 0 
  puts "#{datelogs} dated logs sorted."
else
  puts "Dated logs are already sorted."
end

if numlogs > 0
  puts "#{numlogs} numbered logs sorted."
else
  puts "Numbered logs are already sorted."
end

if (datelogs + numlogs > 0)
  puts "iChat logs are now organized."
  puts "Completed in #{timediff} seconds."
end