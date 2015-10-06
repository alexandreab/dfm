class Comparator
  def get_dir_files(root_dir)
    @files = []
    Dir.foreach(root_dir) { |x| @files << "#{root_dir}/#{x}" }
    return @files
  end
end
