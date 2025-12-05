class RangeBuilder
  def self.build(range_str)
    Range.new(*range_str.split("-").map(&:to_i))
  end
end

class RangeMerger
  def self.merge(ranges)
    min = ranges.map(&:min).min
    max = ranges.map(&:max).max
    Range.new(min, max)
  end
end

class Kitchen
  def initialize(fresh_list)
    @fresh_ranges = []
    fresh_list.map do |range_str|
      add_range(RangeBuilder.build(range_str))
    end
  end

  def fresh?(ingredient)
    @fresh_ranges.any? { |range| range.include?(ingredient.to_i) }
  end

  def total_fresh
    @fresh_ranges.inject(0) { |sum, range| sum + range.size }
  end

  private

  def add_range(range)
    existing_ranges = @fresh_ranges.select { |existing| existing.overlap?(range) }

    if existing_ranges.any?
      delete_existing_ranges(existing_ranges)
      create_merged_range(existing_ranges, range)
    else
      @fresh_ranges << range
    end
  end

  def delete_existing_ranges(ranges)
    ranges.each { |range| @fresh_ranges.delete(range) }
  end

  def create_merged_range(existing_ranges, new_range)
    @fresh_ranges << RangeMerger.merge(existing_ranges + [ new_range ])
  end
end
