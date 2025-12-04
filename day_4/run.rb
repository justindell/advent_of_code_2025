require_relative 'forklift'

puts Forklift.new(File.read("input.txt")).rolls
puts Forklift.new(File.read("input.txt")).rolls_with_removal
