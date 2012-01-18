module Spin
  class TestRunner
    
    class << self
      attr_accessor :running, :pid
      alias_method :running?, :running
    end
    
    def self.idle?
      !running?
    end
    
    def self.run(path_collection)
      puts "running tests: #{path_collection.paths}"
      
      self.pid = fork { 
        path_collection.paths.each { |path| require path }
      }
      
      self.running = true
    end
  end
end
