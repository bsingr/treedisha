module TestDirHelper
  def self.path(subpath)
    File.join(File.dirname(__FILE__), "..", "test_dir", subpath)
  end
end