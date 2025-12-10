require "minitest/autorun"
require_relative "circuits"
require_relative "connection"
require_relative "box"

class CircuitsTest < Minitest::Test
  def setup
    @circuits = Circuits.new
    @boxes = [
      Box.new(1, 2, 3),
      Box.new(4, 5, 6),
      Box.new(7, 8, 9),
      Box.new(10, 11, 12)
    ]
  end

  def test_creates_a_new_circuit
    @circuits.add(Connection.new(@boxes[0], @boxes[1]))
    @circuits.add(Connection.new(@boxes[2], @boxes[3]))

    assert_equal 2, @circuits.size
    assert_equal 2, @circuits[0].boxes.size
    assert_equal 2, @circuits[1].boxes.size
  end

  def test_adds_to_existing_circuit
    @circuits.add(Connection.new(@boxes[0], @boxes[1]))
    @circuits.add(Connection.new(@boxes[1], @boxes[2]))
    @circuits.add(Connection.new(@boxes[0], @boxes[2]))

    assert_equal 1, @circuits.size
    assert_equal 3, @circuits[0].boxes.size
  end
end
