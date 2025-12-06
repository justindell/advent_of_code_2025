Problem = Struct.new(:inputs) do
  def solve
    numbers.inject { |acc, n| acc.send(operator, n) }
  end

  def <<(input)
    return unless input && !input.empty?

    inputs << input
  end

  private

  def numbers = inputs[0..-2].map(&:to_i)
  def operator = inputs.last
end

class CephalopodMath
  def initialize(input)
    @problems = []
    input.each_line { |line| parse_line(line) }
  end

  def total
    @problems.sum { |problem| problem.solve }
  end

  private

  def parse_line(line)
    line.strip.split(/\s+/).each_with_index do |token, index|
      return unless token

      @problems[index] ||= Problem.new([])
      @problems[index] << token.strip
    end
  end
end
