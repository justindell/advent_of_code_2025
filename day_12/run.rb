require_relative "parser"
require "debug"

parser = Parser.new(File.read("input.txt"))

puts "Total trees: #{parser.trees.size}"
puts "Easy fit trees: #{parser.trees.count(&:easy_fit?)}"
puts "Won't fit trees: #{parser.trees.count(&:wont_fit?)}"
