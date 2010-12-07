# stdlib
require "digest/sha1"

require File.join(File.dirname(__FILE__), "treedisha/filesystem")
require File.join(File.dirname(__FILE__), "treedisha/comparator")

module Treedisha
  def self.list(root_path)
    Treedisha::Filesystem.all_files_with_sha1(root_path)
  end
  
  def self.compare(list_after, list_before)
    Treedisha::Comparator.new(list_after, list_before)
  end
end