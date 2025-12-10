require "minitest/autorun"
require_relative "machine"

class MachineTest < Minitest::Test
  def test_should_parse_lines_from_manual
    line = "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}"
    parser = Machine.new(line)

    assert_equal [ false, true, true, false ], parser.lights.diagram
    assert_equal 6, parser.wiring.count
    assert_equal [ 1, 3 ], parser.wiring[1]
  end

  def test_should_find_fewest_toggles
    assert_equal 2, Machine.new("[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}").fewest_toggles
    assert_equal 3, Machine.new("[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}").fewest_toggles
    assert_equal 2, Machine.new("[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}").fewest_toggles
    assert_equal 1, Machine.new("[##.#] (0,1,3) (0,1,2,3) {29,29,18,29}").fewest_toggles
  end
end
