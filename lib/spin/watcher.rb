require 'listen'

module Spin
  module Watcher
    extend self

    AppDirectories = ['app/models', 'app/controllers', 'app/views']
    TestDirectories = ['test/unit', 'test/functional', 'test/integration']

    def spawn
      rd, wr = IO.pipe

      fork {
        rd.close

        dirs = AppDirectories + TestDirectories
        Listen.to(*dirs, :filter => /\.rb$/, :latency => 0.1) do |modified, added, removed|
          changed_files = [modified + added + removed].uniq

          files_to_queue = changed_files.map { |file|
            Alternate.for(file)
          }

          # puts?
          wr.write files_to_queue.flatten.join(File::PATH_SEPARATOR)
        end
      }

      wr.close
      rd
    end
  end
end

