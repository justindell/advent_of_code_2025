require_relative "tachyon"

puts Tachyon.new(File.read("input.txt").lines).total_splits
puts Tachyon.new(File.read("input.txt").lines).total_timelines
