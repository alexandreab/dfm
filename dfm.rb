#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
require "fileutils"
require File.expand_path("lib/comparator")
require File.expand_path("lib/directory")

#FIXME This doesn't work for file names with whitespace
args = Hash[ ARGV.join(' ').scan(/--?([^\s]+)(?:\s(\S+))?/) ]

if args.key?('help')
  help_file = File.open('doc/dfm_help.txt', "r")
  data = help_file.read
  puts data
  Kernel.exit
end

if not args.key?('file')
  target_file_path = nil
else
  target_file_path = File.expand_path(args['file'])
end

if not args.key?('directory')
  target_directory = '.'
else
  if not Dir.exist?(args['directory'])
    abort("dfm: invalid argument directory.\n"+
          "This directory doesn't exist.\n"+
          "Try 'dfm --help' for more information.")
  end
  target_directory = args['directory']
end

if not args.key?('action')
  action = "no-delete"
elsif args['action']=="delete"
  action = "delete"
elsif args['action']=="ask-to-delete"
  action = "ask-to-delete"
else
  abort("dfm: invalid argument action.\n"+
        "Try 'dfm --help' for more information.")
end

c = Comparator.new
c.compare(target_directory, target_file_path, action)

puts c

c.action(action)
