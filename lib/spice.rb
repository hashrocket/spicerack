require 'open-uri'

class Spice

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def ingredients
    recipe = open("https://raw.github.com/hashrocket/spices/master/#{name}/spice.yml")
    YAML.parse(recipe).to_ruby[name].map do |info|
      Ingredient.new(name, info['source'], info['rails'])
    end
  end

  def add_ingredients
    ingredients.each do |ingredient|
      ingredient.add
    end
  end

  def display_usage
    Spicerack::Usage.new(self.name).display_message
  end

end
