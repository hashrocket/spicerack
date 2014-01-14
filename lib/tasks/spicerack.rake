require 'yaml'
require 'open-uri'

namespace :spicerack do

  def get_destination(path)
    ENV["GEM_TESTING"] ? "tmp/#{path}" : path
  end

  spice_file = File.expand_path('../../files.yml', __FILE__)
  spice_yaml = YAML.load_file(spice_file)

  spice_yaml["spices"].keys.each do |spice|
    desc "Install #{spice}"
    task spice.to_sym => :environment do

      spice_yaml["spices"][spice].each do |file|
        destination = get_destination(file['rails'])
        FileUtils.mkdir_p(File.dirname(destination))

        File.open(destination, 'wb') do |f|
          f.write open(file['source']).read
        end

      end
    end
  end

end
