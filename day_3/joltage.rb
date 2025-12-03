class Joltage
  def initialize(line)
    @chars = line.chars.map(&:to_i)
  end

  def amount
    "#{tens}#{ones}".to_i
  end

  private

  def tens
    @chars[0..-2].max
  end

  def ones
    @chars[(@chars.index(tens) + 1)..-1].max
  end
end

puts File
  .readlines('input.txt')
  .map(&:chomp)
  .map { |line| Joltage.new(line).amount }
  .sum
