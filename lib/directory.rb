class Directory

  attr_reader :local_files
  attr_reader :local_dirs

  def initialize(root, recursive=false, parent="")
    @root = root
    @recursive = recursive
    @parent = parent
    if @parent == ""
      @absolute_path = "."
    else
      @absolute_path = "#{@parent}/#{root}"
    end

    @local_files =  Dir.entries(@absolute_path).select {|entry| !File.directory? File.join(@absolute_path,entry) and !(entry =='.' || entry == '..') }
    @local_dirs =  Dir.entries(@absolute_path).select {|entry| File.directory? File.join(@absolute_path,"#{entry}/") and !(entry =='.' || entry == '..') }

    if recursive
      self.get_children()
    end
  end

  def get_children()
    @local_dir_obj  = []
    for dir in @local_dirs
      @local_dir_obj  << Directory.new(dir, true, @absolute_path)
    end
  end

  def to_s
    "Files: #{@local_files}\nDirectories: #{@local_dirs}"
  end
end
