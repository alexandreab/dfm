require File.expand_path("lib/directory")
class Comparator
  def compare(target_directory, file_to_compare=nil)
    equal_files = Array.new
    c = Directory.new(target_directory, recursive=true)
    puts "File to compare: "+file_to_compare
    files = c.files
    files.each() { |x| equal_files.push(x) if FileUtils.cmp(file_to_compare, x) and file_to_compare != x }

    puts equal_files
  end
end
