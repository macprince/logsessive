#!/usr/bin/ruby
require "ftools"
Dir.chdir(File.expand_path("~/Documents/iChats"))
Dir.new(File.expand_path("~/Documents/iChats")).each {
  |x| 
    if File.ftype(x) != "directory"
      if /(\d\d\d\d-\d\d-\d\d)/.match(x)
        File.makedirs $1
        File.move(x, $1)
      end
    end
}
