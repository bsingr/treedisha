module FixturesHelper
  def self.read_file(filename)
    path = File.join(File.dirname(__FILE__), "..", "fixtures", filename)
    File.read(path)
  end
  
  def self.read_json_file(filename)
    JSON.parse(read_file(filename))
  end
end