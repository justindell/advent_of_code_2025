require_relative "file_parser"
require_relative "kitchen"

parsed = FileParser.new("input.txt")
kitchen = Kitchen.new(parsed.fresh_ranges)

puts parsed.available_ingredients.count { |ingredient| kitchen.fresh?(ingredient) }
