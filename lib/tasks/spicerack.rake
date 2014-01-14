require 'yaml'
require 'open-uri'

namespace :spicerack do

  def get_destination(path)
    ENV["GEM_TESTING"] ? "tmp/#{path}" : path
  end

  def get_source(file)
    source = file['source']
    source = File.expand_path("../../templates/#{source}", __FILE__) if file['localfile']
    source
  end

  spice_file = File.expand_path('../../spicerack.yml', __FILE__)
  spice_yaml = YAML.load_file(spice_file)

  spice_yaml["spices"].keys.each do |spice|
    desc "Install #{spice}"
    task spice.to_sym => :environment do

      spice_yaml["spices"][spice].each do |file|
        destination = get_destination(file['rails'])
        FileUtils.mkdir_p(File.dirname(destination))

        File.open(destination, 'wb') do |f|
          source = get_source(file)
          f.write open(source).read
        end

      end
    end
  end

end
