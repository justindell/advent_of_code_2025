require "minitest/autorun"
require_relative "kitchen"

class KitchenTest < Minitest::Test
  FRESH_LIST = [
   "3-5",
   "10-14",
   "16-20",
   "12-18"
  ].freeze

  def setup
    @kitchen = Kitchen.new(FRESH_LIST)
  end

  def test_should_determine_fresh_ingredients
    refute @kitchen.fresh?("1"),  "Ingredient '1' should not be fresh"
    assert @kitchen.fresh?("5"),  "Ingredient '5' should be fresh"
    refute @kitchen.fresh?("8"),  "Ingredient '8' should not be fresh"
    assert @kitchen.fresh?("11"), "Ingredient '11' should be fresh"
    assert @kitchen.fresh?("17"), "Ingredient '17' should be fresh"
    refute @kitchen.fresh?("32"), "Ingredient '32' should not be fresh"
  end
end
