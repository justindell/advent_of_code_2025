require_relative "lights"
require_relative "wiring"
require "debug"

class Machine
  LINE_REGEX = /^\[(?<lights>[\.#]+)\](?<wiring>[^\{]+)\{(?<joltage>[^\}]+)\}$/

  def initialize(line)
    @line = line
  end

  def fewest_toggles
    combinations = 1
    loop do
      found = find_success_for(combinations)
      return found if found

      combinations += 1
    end
  end

  def lights
    @lights ||= Lights.build_from(parsed_line[:lights])
  end

  def wiring
    @wiring ||= Wiring.build_from(parsed_line[:wiring])
  end

  def joltage
    nil
  end

  private

  def parsed_line
    @parsed_line ||= LINE_REGEX.match(@line)
  end

  def find_success_for(combinations)
    wiring.connections.combination(combinations).each do |wiring_combination|
      test_combination(wiring_combination)
      return combinations if lights.success?
    end
    nil
  end

  def test_combination(wiring_combination)
    lights.reset
    wiring_combination.each do |positions|
      lights.toggle(*positions)
    end
  end
end
