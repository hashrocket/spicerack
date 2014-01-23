require 'spice_loader'
require 'spice'

describe SpiceLoader do

  describe '#spices' do

    let(:spices) { SpiceLoader.spices }

    it 'returns a array of spice objects' do
      spices.first.should be_kind_of Spice
      spices.count.should > 4
      spices.map(&:name).should include "cask"
      spices.map(&:name).should include "sortr"
    end

  end

end
