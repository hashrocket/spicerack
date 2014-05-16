require 'spicerack/cabinet'

describe Spicerack::Cabinet do
  describe '#spices' do
    let(:spices) { described_class.spices }

    it 'returns a array of spice objects' do
      spices.first.should be_kind_of Spicerack::Spice
      spices.count.should > 4
      spices.map(&:name).should include "cask"
      spices.map(&:name).should include "sortr"
    end
  end
end
