class Polygon
  def initialize(edges)
    @edges = edges
  end

  def rectangle_inside?(point1, point2)
    x_min, x_max = [ point1.x, point2.x ].minmax
    y_min, y_max = [ point1.y, point2.y ].minmax

    @edges.each do |edge|
      return false if edge.horizontal? && inside?(edge.y, y_min, y_max) && horizontal_intersects?(edge, x_min, x_max)
      return false if edge.vertical? && inside?(edge.x, x_min, x_max) && vertical_intersects?(edge, y_min, y_max)
    end
    true
  end

  private

  def inside?(x, a, b)
    (a < x && x < b)
  end

  def vertical_intersects?(edge, y_min, y_max)
    (edge.min_y <= y_min && edge.max_y > y_min) || (edge.min_y < y_max && edge.max_y >= y_max)
  end

  def horizontal_intersects?(edge, x_min, x_max)
    (edge.min_x <= x_min && edge.max_x > x_min) || (edge.min_x < x_max && edge.max_x >= x_max)
  end
end
