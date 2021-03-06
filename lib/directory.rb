class Directory

  attr_reader :files
  attr_reader :dirs

  def initialize(root, recursive=true)
    Dir.chdir(root)
    @root = Dir.pwd

    if !recursive
      f_regex = root
    else
      f_regex = "#{root}/**/*"
    end

    @files = Array.new
    Dir.glob(f_regex){|f| @files.push(File.expand_path(f)) if !File.directory? f}
  end

  def to_s
    "Files:\n" + @files.join("\n")
  end
end
