require_relative "lights"
require_relative "wiring"
require_relative "joltage_solver"
require "debug"

class Machine
  LINE_REGEX = /^\[(?<lights>[\.#]+)\](?<wiring>[^\{]+)\{(?<joltage>[^\}]+)\}$/

  def initialize(line)
    @line = line
  end

  def fewest_toggles
    combinations = 1
    loop do
      found = find_indicator_success_for(combinations)
      return found if found

      combinations += 1
    end
  end

  def fewest_joltage
    JoltageSolver.new(wiring, joltage).solve
  end

  def lights
    @lights ||= Lights.build_from(parsed_line[:lights], joltage)
  end

  def wiring
    @wiring ||= Wiring.build_from(parsed_line[:wiring])
  end

  def joltage
    @joltage ||= parsed_line[:joltage].split(",").map(&:to_i)
  end

  private

  def parsed_line
    @parsed_line ||= LINE_REGEX.match(@line)
  end

  def find_indicator_success_for(combinations)
    wiring.connections.combination(combinations).each do |wiring_combination|
      test_combination(wiring_combination)
      return combinations if lights.indicator_success?
    end
    nil
  end

  def test_combination(wiring_combination)
    lights.reset
    wiring_combination.each do |positions|
      lights.toggle(*positions)
    end
  end

  def find_joltage_success_for(combinations)
    debugger
    puts "Trying #{combinations}. Possible combinations: #{(combinations+1)*(combinations+2)/2}"
    puts wiring.connections.repeated_combination(combinations).count
    wiring.connections.repeated_combination(combinations).each_with_index do |wiring_combination, index|
      test_joltage_combination(wiring_combination)
      return combinations if lights.joltage_success?
    end
    nil
  end

  def test_joltage_combination(wiring_combination)
    lights.reset
    wiring_combination.each do |positions|
      lights.increase_joltage(*positions)
      return if lights.joltage_impossible?
    end
  end
end
