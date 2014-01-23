require 'spice'
require 'ingredient'

describe Spice do

  describe "#ingredients" do

    let(:spice) { Spice.new("cask") }

    it 'returns an array of ingredients for that spice' do
      result = spice.ingredients
      result.should be_kind_of Array
      result.length.should > 1
      result.first.should be_kind_of Ingredient
    end

  end

end
