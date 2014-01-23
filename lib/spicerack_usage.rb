require 'open-uri'

module Spicerack
  class Usage

    attr_accessor :spice

    def initialize(spice)
      self.spice = spice
    end

    def display_message
      puts usage_text unless ENV['GEM_TESTING']
    end

    def usage_text
      begin; "\n" + open(usage_file_path).read; rescue; end
    end

    def usage_file_path
      "https://raw.github.com/hashrocket/spices/master/#{spice}/USAGE"
    end

  end
end
