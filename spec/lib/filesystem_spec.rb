require "spec_helper"

describe Treedisha::Filesystem do
  it "should be possible to list all files" do
    path = TestDirHelper.path(".")
    Treedisha::Filesystem.all_files(path).empty?.should be_false
    Treedisha::Filesystem.all_files(path).size == 1
  end
  
  it "should be possible to get sha1 for a file" do
    path = TestDirHelper.path("foo.fx")
    Treedisha::Filesystem.sha1_for_file(path).should == "83a4f6db0964dd03480be5f781eec6c5c2f7f5f2"
  end
end