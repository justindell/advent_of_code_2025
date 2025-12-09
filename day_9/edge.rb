require_relative "point"

class Edge < Data.define(:start_point, :end_point)
  def vertical? = start_point.x == end_point.x
  def horizontal? = start_point.y == end_point.y

  def x = start_point.x
  def y = start_point.y

  def min_y = [ start_point.y, end_point.y ].min
  def max_y = [ start_point.y, end_point.y ].max
  def min_x = [ start_point.x, end_point.x ].min
  def max_x = [ start_point.x, end_point.x ].max
end
