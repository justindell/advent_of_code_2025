require "minitest/autorun"
require_relative "polygon"
require_relative "edge"
require_relative "point"

class PolygonTest < Minitest::Test
  def setup
    @polygon = Polygon.new([
      Edge.new(Point.new(2, 2), Point.new(2, 8)),
      Edge.new(Point.new(2, 8), Point.new(8, 8)),
      Edge.new(Point.new(8, 8), Point.new(8, 2)),
      Edge.new(Point.new(8, 2), Point.new(2, 2))
    ])
  end

  def test_should_determine_if_a_rectangle_is_inside_polygon
    assert @polygon.rectangle_inside?(Point.new(3, 3), Point.new(7, 7))
  end

  def test_should_determine_if_a_rectangle_is_outside_polygon
    refute @polygon.rectangle_inside?(Point.new(1, 1), Point.new(3, 3))
  end
end
