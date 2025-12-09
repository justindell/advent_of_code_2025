require "minitest/autorun"
require_relative "point"

class PointTest < Minitest::Test
  def test_should_find_area_between_points
    assert_equal 24, Point.new(2, 5).area(Point.new(9, 7))
    assert_equal 35, Point.new(7, 1).area(Point.new(11, 7))
    assert_equal 6, Point.new(7, 3).area(Point.new(2, 3))
    assert_equal 50, Point.new(2, 5).area(Point.new(11, 1))
  end
end
