require "debug"

Point = Struct.new(:x, :y, :roll, :marked_for_removal) do
  def hash = [ x, y ].hash

  def add(x, y)
    Point.new(self.x + x, self.y + y, self.roll, false)
  end

  def mark_for_removal
    self.marked_for_removal = true
  end

  def remove
    return unless marked_for_removal

    self.marked_for_removal = false
    self.roll = false
  end
end

Line = Data.define(:string, :row) do
  def points
    string.chars.map.with_index do |char, col|
      Point.new(row, col, char == "@", false)
    end
  end
end

class PointIndex
  def initialize(map)
    @index ||= map.to_h do |point|
      [ point.hash, point ]
    end
  end

  def find(point)
    @index[point.hash]
  end
end

class Forklift
  TOO_MANY_ADJACENT_ROLLS = 4
  NEIGHBOR_LOCATIONS = [
    [ -1, -1 ], [ -1,  0 ], [ -1,  1 ],
    [  0, -1 ],             [  0,  1 ],
    [  1, -1 ], [  1,  0 ], [  1,  1 ]
  ].freeze

  def initialize(map)
    @map = map.split("\n").map.with_index do |line, x|
      Line.new(line, x).points
    end.flatten
  end

  def rolls
    @map.select(&:roll).inject(0) do |total, point|
      adjacent_rolls = adjacent_points(point).select(&:roll)
      total += mark_and_tally(point) if adjacent_rolls.size < TOO_MANY_ADJACENT_ROLLS
      total
    end
  end

  def rolls_with_removal
    total_rolls = 0

    loop do
      rolls_this_pass = find_and_remove
      break if rolls_this_pass == 0

      total_rolls += rolls_this_pass
    end
    total_rolls
  end

  private

  def points_index
    @points_index ||= PointIndex.new(@map)
  end

  def adjacent_points(point)
    NEIGHBOR_LOCATIONS.map do |offset_x, offset_y|
      points_index.find(point.add(offset_x, offset_y))
    end.compact
  end

  def mark_and_tally(point)
    point.mark_for_removal
    1
  end

  def find_and_remove
    rolls.tap { remove_rolls_marked_for_removal }
  end

  def remove_rolls_marked_for_removal
    @map.each(&:remove)
  end
end
