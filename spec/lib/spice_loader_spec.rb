require 'spice_loader'

describe SpiceLoader do

  describe '#spice_list' do

    it 'returns a array of spice names in the github spices repo' do
      folders = SpiceLoader.new.spice_list
      folders.should include 'cask'
      folders.should include 'minical'
      folders.should_not include 'README.md'
    end

  end

  describe "#get_yaml_for" do

    it 'gets the yaml for that spice' do
      result = SpiceLoader.new.get_yaml_for('cask')
      result.should be_kind_of Array
      result.length.should > 1
      result.first.should be_kind_of Hash
      result.first.keys.should include "source"
      result.first.keys.should include "rails"
    end
  end

end
