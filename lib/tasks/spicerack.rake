require 'yaml'
require 'open-uri'

namespace :spicerack do

  desc 'install cask'
  task cask: :environment do
    spice_file = File.expand_path('../../files.yml', __FILE__)
    spice_yaml = YAML.load_file(spice_file)

    def get_destination(path)
      ENV["TESTING"] ? "tmp/#{path}" : path
    end

    spice_yaml["spices"]["cask"].each do |file|
      destination = get_destination(file['rails'])
      FileUtils.mkdir_p(File.dirname(destination))

      File.open(destination, 'w') do |f|
        f.write open(file['source']).read
      end
    end

  end
end
