require_relative "junction"
require_relative "box"

input = File.readlines("input.txt").map do |line|
  x, y, z = line.split(",").map(&:to_i)
  Box.new(x, y, z)
end

junction = Junction.new(input)
loop do
  print "."
  junction.wire_closest_connection
end
