require 'open-uri'
require 'json'

class SpiceLoader

  def spice_list
    items = JSON.parse(open('https://api.github.com/repos/hashrocket/spices/contents/').string)
    items.select! { |item| item['type'] == 'dir' }
    items.map { |item| item['name'] }
  end

  def get_yaml_for(spice)
    recipe = open("https://raw.github.com/hashrocket/spices/master/#{spice}/recipe.yml")
    YAML.parse(recipe).to_ruby[spice]
  end

end
