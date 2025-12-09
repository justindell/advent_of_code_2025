require "minitest/autorun"
require_relative "connection"
require_relative "box"

class ConnectionTest < Minitest::Test
  def test_calculates_distance_from_wall
    box_a = Box.new(216, 146, 977)
    box_b = Box.new(117, 168, 530)
    connection = Connection.new(box_a, box_b)

    assert_equal 25272, connection.distance_from_wall
  end
end
