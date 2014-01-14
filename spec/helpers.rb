require 'open-uri'

module Helpers

  def assert_remote_file_contents(file, url)
    open("tmp/#{file}").each_byte.to_a.should == open(url).each_byte.to_a
  end

end
