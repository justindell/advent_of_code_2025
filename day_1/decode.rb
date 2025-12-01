START = 50

class Instruction
  STRING_REGEX = /([RL])(\d+)/

  def self.from_string(string)
    new(*string.match(STRING_REGEX)[1..2])
  end

  def initialize(direction, steps)
    @direction = direction
    @steps = steps
  end

  def steps = @steps.to_i
  def direction = @direction == "R" ? "right" : "left"
end

class Position
  attr_reader :zeroes

  def initialize(position)
    @position = position
    @zeroes = 0
  end

  def move(instruction)
    instruction.steps.times { send("move_#{instruction.direction}") }
    @zeroes += 1 if @position == 0
  end

  private

  def move_left
    @position == 0 ? @position = 99 : @position -= 1
  end

  def move_right
    @position == 99 ? @position = 0 : @position += 1
  end
end

class Dial
  def initialize
    @position = Position.new(START)
  end

  def run(inputs)
    inputs.each do |input|
      instruction = Instruction.from_string(input)
      @position.move(instruction)
    end
    @position.zeroes
  end
end

input = File.readlines("input.txt").map(&:chomp)
Dial.new.run(input).tap { |result| puts "Result: #{result}" }
