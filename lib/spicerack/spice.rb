require 'yaml'
require 'http'
require 'spicerack/ingredient'
require 'spicerack/usage'

module Spicerack
  class Spice
    URL_TEMPLATE = 'https://raw.githubusercontent.com/hashrocket/spices/master/{{name}}/spice.yml'

    def self.wrap(names)
      names.map { |name| new(name) }
    end

    attr_reader :name

    def initialize(name, options = {})
      @name         = name.to_s
      @url_template = options[:url_template] || URL_TEMPLATE
    end

    def ingredients
      recipe = HTTP.with(:accept => 'application/json')
        .get(url)
      YAML.load(recipe.to_s)[name].map do |info|
        Ingredient.new(name, info['source'], info['rails'])
      end
    end

    def add_ingredients
      ingredients.each do |ingredient|
        ingredient.add
      end
    end

    def display_usage
      Spicerack::Usage.new(name).display_message
    end

    private

    def url
      @url_template.gsub('{{name}}', name)
    end
  end
end
