require "matrix"

class Problem
  def initialize
    @numbers = []
    @operator = nil
  end

  def solve
    return 0 if @numbers.empty? || !@operator

    @numbers.inject { |acc, number| acc.send(@operator, number) }
  end

  def parse_line(line)
    operator = line[-1].strip
    number = line[0..-2].join.strip
    @numbers << number.to_i unless number.empty?
    @operator = operator unless operator.empty?
  end
end

class CephalopodMath
  def initialize(input)
    @problems = []
    current_problem = Problem.new
    build_matrix(input.lines).each do |line|
      if line.all? { |char| char == " " }
        @problems << current_problem
        current_problem = Problem.new
      end

      current_problem.parse_line(line)
    end
    @problems << current_problem
  end

  def total
    @problems.sum { |problem| problem.solve }
  end

  private

  def build_matrix(lines)
    matrix = []
    longest_line = lines.map(&:length).max
    lines.map do |line|
      matrix << (line.chomp.chars + Array.new(longest_line, ""))[0...longest_line]
    end
    Matrix[*matrix].column_vectors.map(&:to_a).reverse
  end
end
