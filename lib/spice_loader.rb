require 'open-uri'
require 'json'

class SpiceLoader

  def self.spices
    items = JSON.parse(open('https://api.github.com/repos/hashrocket/spices/contents/').string)
    items.select! { |item| item['type'] == 'dir' }
    items.map do |item|
      Spice.new(item['name'])
    end
  end

end
