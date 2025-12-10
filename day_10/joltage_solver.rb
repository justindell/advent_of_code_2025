require "z3"
require "debug"

class JoltageSolver
  def initialize(wiring, joltage)
    @buttons = wiring.connections
    @joltage = joltage
    @optimizer = Z3::Optimize.new
  end

  def solve
    setup_joltage_constraints
    total_presses = button_presses.inject(:+)
    @optimizer.minimize(total_presses)
    find_solution
  end

  private

  def setup_joltage_constraints
    @joltage.each_with_index do |joltage, index|
      matching_buttons = find_matching_buttons(index)
      @optimizer.assert matching_buttons.inject(:+) == joltage
    end
  end

  def find_matching_buttons(joltage)
    @buttons.filter_map.with_index do |conn, idx|
      button_presses[idx] if conn.include?(joltage)
    end
  end

  def button_presses
    @button_presses ||= @buttons.map { |conn| setup_button_press(conn) }
  end

  def setup_button_press(conn)
    Z3.Int("button#{conn}").tap do |button|
      @optimizer.assert button >= 0
    end
  end

  def find_solution
    return unless @optimizer.satisfiable?

    model = @optimizer.model
    button_presses.sum { |btn| model[btn].to_i }
  end
end
