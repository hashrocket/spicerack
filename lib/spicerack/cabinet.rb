require 'json'
require 'http'
require 'spicerack/spice'

module Spicerack
  class Cabinet
    def self.repo_url
      'https://api.github.com/repos/hashrocket/spices/contents'
    end

    def self.spices
      items = JSON.parse(HTTP.get(repo_url))
      names = items.select { |item| item['type'] == 'dir' }.map { |item| item['name'] }
      Spice.wrap(names)
    end

    def self.spice_list
      spices.map { |spice| spice.name }.sort
    end
  end
end
