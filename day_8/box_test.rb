require "minitest/autorun"
require_relative "box"

class BoxTest < Minitest::Test
  def test_distance_between_two_boxes
    one = Box.new(162, 817, 812)
    two = Box.new(57, 618, 57)
    assert_in_delta 787.814, one.distance_to(two), 0.001
  end
end
