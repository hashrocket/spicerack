class Spice

  attr_accessor :file, :destination, :spice

  def initialize(spice, file)
    self.spice = spice
    self.file = file
    self.destination = get_destination
  end

  def run
    if new_or_overwrite?
      write
      display_message
    end
  end

  private

  def write
    create_directories
    File.open(destination, 'wb') do |f|
      source = get_source
      f.write open(source).read
    end
  end

  def create_directories
    FileUtils.mkdir_p(File.dirname(destination))
  end

  def new_or_overwrite?
    File.exist?(destination) ? overwrite? : true
  end

  def overwrite?
    puts "Do you want overwrite #{destination}? [y, n]"
    STDIN.gets == "y\n"
  end

  def localfile?
    !file['source'].include?('://')
  end

  def get_destination
    ENV["GEM_TESTING"] ? "tmp/#{file['rails']}" : file['rails']
  end

  def get_source
    if localfile?
      File.expand_path("../spices/#{spice}/templates/#{file['source']}", __FILE__)
    else
      file['source']
    end
  end

  def display_message
    puts "Added #{file['source']} to #{file['rails']}" unless ENV["GEM_TESTING"]
  end

end
