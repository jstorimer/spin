require 'logger'
require 'forwardable'

module Spin
  class Logger
    extend Forwardable

    attr_reader :logger
    def_delegators :logger, :fatal,
                            :error,
                            :warn,
                            :info,
                            :debug

    def initialize
      @logger = ::Logger.new($stdout)
      @logger.level = level
      @logger.formatter = formatter
    end

  private

    def level
      ::Logger::INFO
    end

    def formatter
      proc { |_, _, _, message| "[#{caller}] #{message}\n" }
    end

    # Returns a "Spin" label for log entries, with color, if supported.
    def caller
      name = "Spin"
      $stdout.isatty ? cyan(name) : name
    end

    # Uses ANSI escape codes to create cyan-colored output.
    def cyan(string)
      "\e[36m#{string}\e[0m"
    end
  end
end
