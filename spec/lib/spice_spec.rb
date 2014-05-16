require 'spicerack/spice'

describe Spicerack::Spice do
  describe "#ingredients" do
    let(:spice) { described_class.new("cask") }

    it 'returns an array of ingredients for that spice' do
      result = spice.ingredients
      expect(result).to be_an(Array)
      expect(result.first).to be_an(Spicerack::Ingredient)
    end
  end
end
