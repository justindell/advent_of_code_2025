class Kitchen
  def initialize(fresh_list)
    @fresh_ranges = fresh_list.map do |range_str|
      Range.new(*range_str.split("-").map(&:to_i))
    end
  end

  def fresh?(ingredient)
    @fresh_ranges.any? { |range| range.include?(ingredient.to_i) }
  end
end
