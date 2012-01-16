require 'fssm'

module Spin
  class Watcher
    class << self
      attr_reader :pid
      
      def spawn(write_pipe)
        @pid = fork {
          watch(write_pipe)
        }
      end
      
      def watch(write_pipe)
        FSSM.monitor do
          path 'test/' do
            update { |base, relative| 
              full_path = [base, relative].join('/')
              write_pipe.puts(full_path)
            }
            
            create { |base, relative| stub }
          end
        end
      end
    end
  end
end
