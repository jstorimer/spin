require 'spin'
require 'optparse'

module Spin
  module CLI
    class << self
      def run(argv)
        force_rspec = false
        force_testunit = false
        time = false
        push_results = false
        preload = "config/application.rb"

        options = OptionParser.new do |opts|
          opts.banner = usage
          opts.separator ""
          opts.separator "Server Options:"

          opts.on("-I", "--load-path=DIR#{File::PATH_SEPARATOR}DIR", "Appends directory to $LOAD_PATH") do |dirs|
            $LOAD_PATH.concat(dirs.split(File::PATH_SEPARATOR))
          end

          opts.on('--rspec', 'Force the selected test framework to RSpec') do |v|
            force_rspec = v
          end

          opts.on('--test-unit', 'Force the selected test framework to Test::Unit') do |v|
            force_testunit = v
          end

          opts.on('-t', '--time', 'See total execution time for each test run') do |v|
            time = true
          end

          opts.on('--push-results', 'Push test results to the push process') do |v|
            push_results = v
          end

          opts.on('--preload FILE', "Preload this file instead of #{preload}") do |v|
            preload = v
          end

          opts.separator "General Options:"
          opts.on('-e', 'Stub to keep kicker happy')
          opts.on('-v', '--version', 'Show Version') do
            puts Spin::VERSION; exit
          end
          opts.on('-h', '--help') do
            $stderr.puts opts
            exit
          end
        end
        options.parse!

        subcommand = argv.shift
        case subcommand
        when 'serve' then Spin.serve(force_rspec, force_testunit, time, push_results, preload)
        when 'push' then Spin.push(preload, argv)
        else
          $stderr.puts options
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
