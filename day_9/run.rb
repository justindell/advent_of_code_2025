require_relative "tiles"

puts Tiles.new(File.read("input.txt")).largest_area
