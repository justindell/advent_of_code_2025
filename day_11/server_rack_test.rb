require "minitest/autorun"
require_relative "server_rack"

class ServerRackTest < Minitest::Test
  def test_count_paths_from_you_to_out
    input = <<~DATA
      aaa: you hhh
      you: bbb ccc
      bbb: ddd eee
      ccc: ddd eee fff
      ddd: ggg
      eee: out
      fff: out
      ggg: out
      hhh: ccc fff iii
      iii: out
    DATA
    rack = ServerRack.new(input, start: "you", target: "out")

    assert_equal 5, rack.count_paths
  end

  def test_count_paths_from_svr_to_out_with_visits
    input = <<~DATA
      svr: aaa bbb
      aaa: fft
      fft: ccc
      bbb: tty
      tty: ccc
      ccc: ddd eee
      ddd: hub
      hub: fff
      eee: dac
      dac: fff
      fff: ggg hhh
      ggg: out
      hhh: out
    DATA
    rack = ServerRack.new(input, start: "svr", target: "out", required_visits: %w[dac fft])

    assert_equal 2, rack.count_paths
  end
end
