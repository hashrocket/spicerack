require 'yaml'
require 'open-uri'
require_relative '../spice'
require_relative '../ingredient'
require_relative '../spice_loader'
require_relative '../spicerack_usage'

namespace :spicerack do

  def generate_rake_tasks
    SpiceLoader.spices.each do |spice|
      desc "Install #{spice.name}"
      task spice.name.to_sym do
        spice.add_ingredients
        spice.display_usage
      end
    end
  end

  generate_rake_tasks

  task :ui do
    content = File.open('config/routes.rb', 'r') { |f| f.read }
    unless content.include?("get 'ui(/:action)'")
      File.open('config/routes.rb', 'w') do |f|
        f.write content.sub "Application.routes.draw do",
          "Application.routes.draw do\n  get 'ui(/:action)', controller: 'ui' unless Rails.env.production?"
      end
    end
  end

end

task :spicerack do
  puts "\nYou can install or update a spice by" +
  " calling \"rake spicerack:<spice_name>\"\n
  Available spices:"

  SpiceLoader.spices.map(&:name).sort.each do |spice|
    puts "  #{spice}"
  end
end
