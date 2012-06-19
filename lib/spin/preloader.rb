module Spin
  module Preloader
    extend self
    attr_reader :files
    @files = []
    @files << File.expand_path('config/application')

    def require_files
      @files.each(&method(:require))
    end
  end
end

