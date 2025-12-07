require_relative "tachyon"

puts Tachyon.new(File.read("input.txt")).total_splits
