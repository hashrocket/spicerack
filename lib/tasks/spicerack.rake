require 'yaml'
require 'open-uri'
require_relative '../spice'

namespace :spicerack do

  def generate_rake_tasks
    spice_file = File.expand_path('../../spicerack.yml', __FILE__)
    spice_yaml = YAML.load_file(spice_file)

    spice_yaml["spices"].keys.each do |spice|
      desc "Install #{spice}"
      task spice.to_sym => :environment do
        spice_yaml["spices"][spice].each do |file|
          Spice.new(file).run
        end
      end
    end
  end

  generate_rake_tasks

  task ui: :environment do
    content = File.open('config/routes.rb', 'r') { |f| f.read }
    unless content.include?("get 'ui(/:action)'")
      File.open('config/routes.rb', 'w') do |f|
        f.write content.sub "Application.routes.draw do",
          "Application.routes.draw do\n  get 'ui(/:action)', controller: 'ui' unless Rails.env.production?"
      end
    end
  end

end
