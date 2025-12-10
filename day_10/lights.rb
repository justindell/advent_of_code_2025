class Lights
  def self.build_from(str, joltage = [])
    new(str.chars.map { |char| char == '#' }, joltage)
  end

  attr_reader :diagram, :state

  def initialize(diagram, joltage_requirement)
    @diagram = diagram
    @joltage_requirement = joltage_requirement
    reset
  end

  def toggle(*positions)
    positions.each do |pos|
      @state[pos] = !@state[pos]
    end
  end

  def increase_joltage(*positions)
    positions.each do |pos|
      @joltage[pos] += 1
    end
  end

  def indicator_success?
    @state == @diagram
  end

  def joltage_success?
    @joltage == @joltage_requirement
  end

  def joltage_impossible?
    @joltage.each_with_index.any? do |current, index|
      current > @joltage_requirement[index]
    end
  end

  def reset
    @state = Array.new(@diagram.size, false)
    @joltage = Array.new(@diagram.size, 0)
  end
end
