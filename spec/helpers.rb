require 'generator_spec'
require 'open-uri'

module Helpers

  def assert_remote_file_contents(file, url)
    File.open("tmp/#{file}", 'r').read.should == open(url).read
  end

end
