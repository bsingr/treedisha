module Treedisha  
  class Comparator
    
    attr_reader :untouched
    attr_reader :created, :deleted
    attr_reader :moved_old_locations, :moved_new_locations
    attr_reader :modified_new_content, :modified_old_content
    attr_reader :modified, :moved
    
    def initialize(new_tree, old_tree)
      @new_tree = new_tree
      @old_tree = old_tree
      
      compare!
    end
    
    private
  
    def compare!
      @untouched = @new_tree & @old_tree
      
      new_tree_without_shared = @new_tree - untouched
      old_tree_without_shared = @old_tree - untouched
      
      @moved_new_locations, created_or_modified_new_content = diff(new_tree_without_shared, old_tree_without_shared)
      @moved_old_locations, deleted_or_modified_old_content = diff(old_tree_without_shared, new_tree_without_shared)
      
      @moved = merge_moved_by_checksum(moved_new_locations, moved_old_locations)

      @modified_new_content, @created = diff_paths(created_or_modified_new_content, deleted_or_modified_old_content)
      @modified_old_content, @deleted = diff_paths(deleted_or_modified_old_content, created_or_modified_new_content)
      
      @modified = merge_modified_by_path(modified_new_content, modified_old_content)
    end
    
    def diff(base_list_without_shared, search_list_without_shared)
      different_paths_by_hash = []
      different_hashes = []
      
      base_list_without_shared.each do |base_hash, base_path|
        found_pair_by_hash = search_list_without_shared.assoc(base_hash)
          
        # shared hash but different path
        if found_pair_by_hash
          different_paths_by_hash << [base_hash, base_path]

        # different hash
        else
          different_hashes << [base_hash, base_path]
        end
      end
      [different_paths_by_hash, different_hashes]
    end
    
    def diff_paths(base_list, search_list)
      shared_paths = []
      different_paths = []
      
      base_list.each do |base_hash, base_path|
        found_pair_by_path = search_list.rassoc(base_path)
        
        # shared path
        if found_pair_by_path
          shared_paths << [base_hash, base_path]
          
        # different path
        else
          different_paths << [base_hash, base_path]
        end
      end
      
      [shared_paths, different_paths]
    end
    
    def merge_moved_by_checksum(new_list, old_list)
      moved = {}
      new_list.each do |new_checksum, new_path|
        if moved[new_checksum]
          moved[new_checksum][:new] << new_path
        else
          found_pairs_by_checksum = old_list.find_all{|old_checksum, old_path| new_checksum == old_checksum}
          moved[new_checksum] = {
            :new_paths => [new_path],
            :old_paths => found_pairs_by_checksum.map{|a,b| b}
          }
        end
      end
      moved
    end
    
    def merge_modified_by_path(new_list, old_list)
      modified = {}
      new_list.each do |new_checksum, new_path|
        modified[new_path] = {:new_checksum => new_checksum}
      end
      old_list.each do |old_checksum, old_path|
        modified[old_path][:old_checksum] = old_checksum
      end
      modified
    end
  end
end