require "minitest/autorun"
require_relative "junction"
require_relative "box"

class JunctionTest < Minitest::Test
  TEST_BOXES = [
    [ 162, 817, 812 ],
    [ 57, 618, 57 ],
    [ 906, 360, 560 ],
    [ 592, 479, 940 ],
    [ 352, 342, 300 ],
    [ 466, 668, 158 ],
    [ 542, 29, 236 ],
    [ 431, 825, 988 ],
    [ 739, 650, 466 ],
    [ 52, 470, 668 ],
    [ 216, 146, 977 ],
    [ 819, 987, 18 ],
    [ 117, 168, 530 ],
    [ 805, 96, 715 ],
    [ 346, 949, 466 ],
    [ 970, 615, 88 ],
    [ 941, 993, 340 ],
    [ 862, 61, 35 ],
    [ 984, 92, 344 ],
    [ 425, 690, 689 ]
  ].freeze

  def setup
    @boxes = TEST_BOXES.map { |x, y, z| Box.new(x, y, z) }
  end

  def test_setup_connections
    junction = Junction.new(@boxes)

    assert_equal 190, junction.connections.size
  end

  def test_closest_new_connection
    junction = Junction.new(@boxes)
    expected = Connection.new(@boxes[0], @boxes[19])

    assert_equal expected, junction.closest_new_connection
  end

  def test_next_closest_connection
    junction = Junction.new(@boxes)
    expected = Connection.new(@boxes[0], @boxes[7])
    junction.closest_new_connection.wire

    assert_equal expected, junction.closest_new_connection
  end

  def test_should_calculate_size_multiple
    junction = Junction.new(@boxes)
    10.times do
      junction.wire_closest_connection
    end

    assert_equal 40, junction.circuit_sizes.max(3).reduce(:*)
  end
end
