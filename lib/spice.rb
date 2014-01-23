class Spice

  attr_accessor :file, :destination, :spice, :source

  def initialize(spice, file)
    self.spice = spice
    self.file = file
    self.source = get_source
    self.destination = get_destination
  end

  def run
    if same_file_exists?
      display_exists_message
      return
    end

    if new_or_overwrite?
      write
      display_added_message
    end
  end

  private

  def write
    create_directories
    File.open(destination, 'wb') do |f|
      f.write open(source).read
    end
  end

  def same_file_exists?
    if File.exist?(destination)
      byte_array(destination) == byte_array(source)
    else
      false
    end
  end

  def byte_array(path)
    open(path).each_byte.to_a
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
      "https://raw.github.com/hashrocket/spices/master/#{spice}/templates/#{file['source']}"
    else
      file['source']
    end
  end

  def display_added_message
    puts "Added #{destination}" unless ENV["GEM_TESTING"]
  end

  def display_exists_message
    puts "#{destination} is up to date" unless ENV["GEM_TESTING"]
  end

end
