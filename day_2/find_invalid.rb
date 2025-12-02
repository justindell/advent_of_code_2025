class ProductId
  def self.from_range(string)
    Range.new(*string.split("-").map(&:to_i)).to_a.map { |product_id| new(product_id) }
  end

  def initialize(id)
    @id = id.to_s
  end

  def id = @id.to_i

  def invalid?
    (1..half_size).each do |digits|
      possible = @id[0, digits]
      return true if @id.gsub(possible, "") == ""
    end
    false
  end

  private

  def left_side = @id[0..(half_size - 1)]
  def right_side = @id[half_size..-1]
  def size = @id.size
  def half_size = size / 2
end

puts File.read("input.txt")
  .chomp
  .split(",")
  .map { |range| ProductId.from_range(range) }
  .flatten
  .select(&:invalid?)
  .map(&:id)
  .sum
