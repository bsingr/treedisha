require "spec_helper"

describe Treedisha::Comparator do
  before(:each) do
    new_tree = FixturesHelper.read_json_file("comparator/state_after.json")
    old_tree = FixturesHelper.read_json_file("comparator/state_before.json")
    
    @comparator = Treedisha::Comparator.new(new_tree, old_tree)
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
      hash.should =~ /new_content/
    end
  end
  
  it "should be possible find modified files and their old content" do
    @comparator.modified_old_content.size.should == 1
    @comparator.modified_old_content.each do |hash, path|
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
end