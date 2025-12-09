require_relative "point"

class Tiles
  def initialize(input)
    @points = input.lines.map do |line|
      Point.new(*line.split(",").map(&:to_i))
    end
  end

  def largest_area
    @points.combination(2).map do |point1, point2|
      point1.area(point2)
    end.max
  end
end
