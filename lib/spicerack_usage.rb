module Spicerack
  class Usage

    attr_accessor :spice

    def initialize(spice)
      self.spice = spice
    end

    def display_message
      puts ("\n" + usage_file) unless ENV['GEM_TESTING']
    end

    def usage_file
      File.read(File.expand_path("../spices/#{spice}/USAGE", __FILE__))
    end

  end
end
