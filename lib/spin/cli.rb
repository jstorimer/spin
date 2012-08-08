require 'spin'
require 'optparse'

module Spin
  module CLI
    class << self
      def run(argv)
        options = {
          :preload => "config/application.rb"
        }

        parser = OptionParser.new do |opts|
          opts.banner = usage
          opts.separator ""
          opts.separator "Server Options:"

          opts.on("-I", "--load-path=DIR#{File::PATH_SEPARATOR}DIR", "Appends directory to $LOAD_PATH") do |dirs|
            $LOAD_PATH.concat(dirs.split(File::PATH_SEPARATOR))
          end

          opts.on("--rspec", "Force the selected test framework to RSpec") { options[:force_rspec] = true }
          opts.on("--test-unit", "Force the selected test framework to Test::Unit") { options[:force_testunit] = true }
          opts.on("-t", "--time", "See total execution time for each test run") { options[:time] = true }
          opts.on("--push-results", "Push test results to the push process") { options[:push_results] = true }
          opts.on("--preload FILE", "Preload this file instead of #{options[:preload]}") { |v| options[:preload] = v }
          opts.separator "General Options:"
          opts.on("-e", "Stub to keep kicker happy")
          opts.on("-v", "--version", "Show Version") { puts Spin::VERSION; exit }
          opts.on("-h", "--help") { $stderr.puts opts; exit }
        end
        parser.parse!

        subcommand = argv.shift
        case subcommand
        when "serve" then Spin.serve(options)
        when "push" then Spin.push(argv, options)
        else
          $stderr.puts parser
          exit 1
        end
      end

      private

      def usage
        <<-USAGE.gsub(/^\s{8}/,"")
          Usage: spin serve
                 spin push <file> <file>...
          Spin preloads your Rails environment to speed up your autotest(ish) workflow.
        USAGE
      end
    end
  end
end
