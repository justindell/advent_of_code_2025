require "minitest/autorun"
require_relative "forklift"

class ForkliftTest < Minitest::Test
  def test_calculate_number_valid_rolls
    assert_equal 13, Forklift.new(sample_input).rolls
  end

  def test_calculate_number_valid_rolls_with_removal
    assert_equal 43, Forklift.new(sample_input).rolls_with_removal
  end

 private

  def sample_input
    <<~INPUT
      ..@@.@@@@.
      @@@.@.@.@@
      @@@@@.@.@@
      @.@@@@..@.
      @@.@@@@.@@
      .@@@@@@@.@
      .@.@.@.@@@
      @.@@@.@@@@
      .@@@@@@@@.
      @.@.@@@.@.
    INPUT
  end
end
