require 'open-uri'

module Helpers

  def assert_file(local, source)
     expect(byte_array("tmp/#{local}")).to be == byte_array(source),
       "Expected #{local} to match #{source}"
  end

  def byte_array(path)
    open(path).each_byte.to_a
  end

end
