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
  abort("dfm: missig argument file.\n"+
        "It is necessary for now.\n"+
        "Try 'dfm --help' for more information.")
else
  target_file_path = args['file']
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

c = Comparator.new
c.compare(target_directory, target_file_path)

#equal_files = Array.new
#Dir.foreach(target_directory) { |x| equal_files.push(x) if FileUtils.cmp(target_file_path, x) and target_file_path != x }
