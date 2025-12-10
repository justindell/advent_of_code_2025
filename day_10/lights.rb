class Lights
  def self.build_from(str)
    new(str.chars.map { |char| char == '#' })
  end

  attr_reader :diagram, :state

  def initialize(diagram)
    @diagram = diagram
    reset
  end

  def toggle(*positions)
    positions.each do |pos|
      @state[pos] = !@state[pos]
    end
  end

  def success?
    @state == @diagram
  end

  def reset
    @state = Array.new(@diagram.size, false)
  end
end
