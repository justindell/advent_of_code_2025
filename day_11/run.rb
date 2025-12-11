require_relative "server_rack"

input = File.read("input.txt")
puts ServerRack.new(input, start: "you", target: "out").count_paths
puts ServerRack.new(input, start: "svr", target: "out", required_visits: %w[dac fft]).count_paths
