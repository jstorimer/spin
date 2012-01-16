module Spin
  class Preloader
    class << self
      def preload
        # Preload Rails.
        require File.expand_path 'config/application'
        puts 'loaded Rails env...'
      end
    end
  end
end