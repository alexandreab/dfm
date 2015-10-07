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
    d = Dir.new(dir)
    while current_elem = d.read
      if !File.directory? d.path+"/"+current_elem
        @files.push(d.path+"/"+current_elem)
      elsif !(current_elem =='.' || current_elem == '..')
        @dirs.push(d.path+"/"+current_elem)
      end
    end
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
