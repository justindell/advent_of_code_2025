require_relative "point"
require_relative "edge"
require_relative "polygon"

class Tiles
  def initialize(input)
    edges, @points = [], []
    input.lines.each_with_index do |line, index|
      @points << Point.new(*line.split(",").map(&:to_i))
      edges << Edge.new(@points[index - 1], @points[index]) if index > 0
    end
    edges << Edge.new(@points[-1], @points[0])
    @polygon = Polygon.new(edges)
  end

  def largest_area
    @points.combination(2).filter_map do |point1, point2|
      next unless @polygon.rectangle_inside?(point1, point2)

      point1.area(point2)
    end.max
  end
end
