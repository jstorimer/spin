require 'set'

module Spin
  class PathCollection
    attr_reader :path_set
    
    def initialize
      @path_set = Set.new
    end
    
    def pending?
      !path_set.empty?
    end
    
    def add(path)
      path_set << path
    end
    
    def paths
      path_set.to_a
    end
  end
end