require_relative "machine"

total = File.readlines("input.txt", chomp: true).map do |line|
  puts line.inspect
  Machine.new(line).fewest_toggles.tap do |toggles|
    puts "Fewest toggles: #{toggles}"
  end
end.sum

puts "Total toggles: #{total}"
