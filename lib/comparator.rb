require File.expand_path("lib/directory")
class Comparator
  def compare(target_directory, file_to_compare=nil, action=nil)
    @equal_files = Array.new
    c = Directory.new(target_directory)
    files = c.files

    if file_to_compare
      files.each() { |x| @equal_files.push(x) if FileUtils.cmp(file_to_compare, x) and file_to_compare != x }
    else
      # FIXME Is this the best way to handle the array?
      for file1 in files
        for file2 in files
          @equal_files.push(file2) if FileUtils.cmp(file1, file2) and file1 != file2 and !@equal_files.member? file1
        end
      end
    end
  end

  def action(action)
    if action=="delete"
      for f in @equal_files
        Kernel.system("rm -v '#{f}'")
      end
    elsif action=="ask-to-delete"
      for f in @equal_files
        Kernel.system("rm -iv '#{f}'")
      end
    else
      puts "No files deleted"
    end
  end

  def to_s
    @equal_files.join("\n") + "\nTotal of equal files: #{@equal_files.size}"
  end
end
