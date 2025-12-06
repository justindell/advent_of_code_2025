require "minitest/autorun"
require_relative "cephalopod_math"

class CephalopodMathTest < Minitest::Test
  SAMPLE_INPUT = <<~INPUT
    123 328  51 64
     45 64  387 23
      6 98  215 314
    *   +   *   +
  INPUT

  def test_calculate_total
    assert_equal 3263827, CephalopodMath.new(SAMPLE_INPUT).total
  end
end
