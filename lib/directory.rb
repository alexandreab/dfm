$DEBUG = true
class Directory

  attr_reader :local_files
  attr_reader :local_dirs

  def initialize(root, recursive=false)
    Dir.chdir(root)
    @root = Dir.pwd
    @dirs = Queue.new
    @files = Queue.new


    if !recursive
      self.list_dir(@root)
    else
      @dirs.push(@root)
      while !@dirs.empty?
        self.list_dir(@dirs.pop)
      end
    end
  end

  def list_dir(dir)
    Dir.chdir(dir)
    local_dirs = Queue.new
    local_files = Queue.new

    local_dirs =  Dir.entries(".").select {|entry| File.directory? entry and !(entry =='.' || entry == '..') }
    local_files =  Dir.entries(".").select {|entry| !File.directory? entry }

    while !local_dirs.empty?
      @dirs.push(Dir.pwd+"/"+local_dirs.pop)
    end
    while !local_files.empty?
      @files.push(Dir.pwd+"/"+local_files.pop)
    end
    #@files << local_files
    #@dirs << local_dirs
  end

  def to_s
    tmp_files = @files
    s_files = Array.new

    while !tmp_files.empty?
      s_files << tmp_files.pop
    end

    "Files:\n" + s_files.join("\n")
  end
end
