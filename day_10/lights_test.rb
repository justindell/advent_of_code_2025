require "minitest/autorun"
require_relative "lights"

class LightsTest < Minitest::Test
  def setup
    @lights = Lights.build_from(".##.")
  end

  def test_should_start_with_all_lights_off
    assert_equal [ false, false, false, false ], @lights.state
    refute @lights.indicator_success?, "Initial state should not be a success"
  end

  def test_should_toggle_lights
    @lights.toggle(2, 3)
    assert_equal [ false, false, true, true ], @lights.state

    @lights.toggle(3)
    assert_equal [ false, false, true, false ], @lights.state
  end

  def test_should_reset_lights
    @lights.toggle(2, 3)
    @lights.reset

    assert_equal [ false, false, false, false ], @lights.state
  end

  def test_should_determine_success_in_first_example
    @lights.toggle(3)
    @lights.toggle(1, 3)
    @lights.toggle(2)

    assert @lights.indicator_success?
  end

  def test_should_determine_success_in_second_example
    @lights.toggle(1, 3)
    @lights.toggle(2, 3)
    @lights.toggle(0, 1)
    @lights.toggle(0, 1)

    assert @lights.indicator_success?
  end

  def test_should_determine_success_in_third_example
    @lights.toggle(3)
    @lights.toggle(2)
    @lights.toggle(2, 3)
    @lights.toggle(0, 2)
    @lights.toggle(0, 1)

    assert @lights.indicator_success?
  end

  def test_should_determine_joltage_success
    lights = Lights.build_from(".##.", [ 1, 1, 2, 3 ])

    lights.increase_joltage(2, 3)
    lights.increase_joltage(0, 3)
    lights.increase_joltage(2)
    lights.increase_joltage(1, 3)

    assert lights.joltage_success?
  end

  def test_should_determine_joltage_impossible
    lights = Lights.build_from(".##.", [ 1, 1, 2, 3 ])

    lights.increase_joltage(1, 2)
    lights.increase_joltage(1, 3)

    assert lights.joltage_impossible?
  end
end
