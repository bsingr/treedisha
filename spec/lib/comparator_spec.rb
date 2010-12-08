require "spec_helper"

describe Treedisha::Comparator do
  before(:each) do
    new_tree = FixturesHelper.read_json_file("comparator_a/state_after.json")
    old_tree = FixturesHelper.read_json_file("comparator_a/state_before.json")
    
    @comparator = Treedisha::Comparator.new(new_tree, old_tree)
  end
  
  it "should throw no error" do
    new_tree = FixturesHelper.read_json_file("comparator_b/state_after.json")
    old_tree = FixturesHelper.read_json_file("comparator_b/state_before.json")
    
    comparator = Treedisha::Comparator.new(new_tree, old_tree)
  end
  
  it "should be possible find unmodified files" do
    @comparator.untouched.size.should == 3
    @comparator.untouched.each do |hash,path|
      path.should =~ /untouched/
    end
  end
    
  it "should be possible find moved files and their new location" do
    @comparator.moved_new_locations.size.should == 2
    @comparator.moved_new_locations.each do |hash, path|
      path.should =~ /file_moved_new_location/
    end
  end
  
  it "should be possible find moved files and their old location" do
    @comparator.moved_old_locations.size.should == 3
    @comparator.moved_old_locations.each do |hash, path|
      path.should =~ /file_moved_old_location/
    end
  end
  
  it "should be possible find modified files and their new content" do
    @comparator.modified_new_content.size.should == 1
    @comparator.modified_new_content.each do |hash, path|
      path.should =~ /file_changed_content/
      hash.should =~ /new_content/
    end
  end
  
  it "should be possible find modified files and their old content" do
    @comparator.modified_old_content.size.should == 1
    @comparator.modified_old_content.each do |hash, path|
      path.should =~ /file_changed_content/
      hash.should =~ /old_content/
    end
  end
  
  it "should be possible find created files" do
    @comparator.created.size.should == 2
    @comparator.created.each do |hash,path|
      path.should =~ /hereby_created/
    end
  end
  
  it "should be possible find deleted files" do
    @comparator.deleted.size.should == 2
    @comparator.deleted.each do |hash,path|
      path.should =~ /hereby_deleted/
    end
  end
  
  it "should be possible to track modified files" do
    @comparator.modified.keys.size.should == 1
    @comparator.modified.each do |path, checksums|
      path.should =~ /file_changed_content/
      checksums[:old_checksum].should =~ /old_content/
      checksums[:new_checksum].should =~ /new_content/
    end
  end
  
  it "should be possible to track moved files" do
    old_paths_count = 0
    new_paths_count = 0
    @comparator.moved.keys.size.should == 2
    @comparator.moved.each do |checksum, paths|
      paths[:old_paths].empty?.should be_false
      old_paths_count += paths[:old_paths].size
      paths[:old_paths].each do |path|
        path.should =~ /file_moved_old_location/
      end
      paths[:new_paths].empty?.should be_false
      new_paths_count += paths[:new_paths].size
      paths[:new_paths].each do |path|
        path.should =~ /file_moved_new_location/
      end
    end
    old_paths_count.should == 3
    new_paths_count.should == 2
  end
end