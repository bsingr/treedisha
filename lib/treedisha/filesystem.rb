module Treedisha
  module Filesystem
    
    def self.all_files(root_path)
      Dir.glob("#{root_path}/**/*").find_all do |f|
        !File.directory? f
      end
    end
    
    def self.all_files_with_sha1(root_path)
      all_files(root_path).map do |f|
        [sha1_for_file(f), f]
      end
    end
    
    def self.sha1_for_file(file)
      Digest::SHA1.file(file).to_s
    end
  end
end