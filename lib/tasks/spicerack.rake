require 'yaml'
require 'open-uri'
require_relative '../spice'
require_relative '../spicerack_usage'

namespace :spicerack do

  def get_yaml
    spice_file = if File.exist?('config/spicerack.yml')
                   'config/spicerack.yml'
                 else
                   File.expand_path('../../spicerack.yml', __FILE__)
                 end
    YAML.load_file(spice_file)
  end

  def generate_rake_tasks
    spice_yaml = get_yaml
    spice_yaml["spices"].keys.each do |spice|

      desc "Install #{spice}"
      task spice.to_sym do

        spice_yaml["spices"][spice].each do |file|
          Spice.new(spice, file).run
        end
        Spicerack::Usage.new(spice).display_message

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
