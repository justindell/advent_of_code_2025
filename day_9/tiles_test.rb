require "minitest/autorun"
require_relative "tiles"

class TilesTest < Minitest::Test
  INPUT = <<~TEXT
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
  TEXT

  def test_should_find_largest_area
    assert_equal 24, Tiles.new(INPUT).largest_area
  end
end
