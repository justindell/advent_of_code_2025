require_relative "machine"

toggles = 0
joltages = 0
File.readlines("input.txt", chomp: true).map do |line|
  puts line.inspect
  toggles += Machine.new(line).fewest_toggles
  puts "  - toggles: #{toggles}"
  joltages += Machine.new(line).fewest_joltage
  puts "  - joltages: #{joltages}"
end

puts "Total toggles: #{toggles}"
puts "Total joltages: #{joltages}"
