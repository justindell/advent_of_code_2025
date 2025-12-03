class Joltage
  LENGTH = 12

  JoltageFinder = Struct.new(:chars, :length, :accumulated) do
    def initialize(chars, length, accumulated = "") = super(chars, length, accumulated)

    def find
      return accumulated.to_i if length == 0

      self.class.new(remaining, length - 1, accumulated + max.to_s).find
    end

    private

    def room_at_end = length * -1
    def max         = chars[0..room_at_end].max
    def remaining   = chars[chars.index(max) + 1..-1]
  end


  def initialize(line)
    @chars = line.chars.map(&:to_i)
  end

  def amount
    JoltageFinder.new(@chars, LENGTH).find
  end
end

puts File
  .readlines('input.txt')
  .map(&:chomp)
  .map { |line| Joltage.new(line).amount }
  .sum
