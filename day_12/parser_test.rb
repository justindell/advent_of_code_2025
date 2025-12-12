require "minitest/autorun"
require_relative "parser"

class ParserTest < Minitest::Test
  INPUT = <<~DATA
    0:
    ###
    ##.
    ##.

    1:
    ###
    ##.
    .##

    2:
    .##
    ###
    ##.

    3:
    ##.
    ###
    ##.

    4:
    ###
    #..
    ###

    5:
    ###
    .#.
    ###

    4x4: 0 0 0 0 2 0
    12x5: 1 0 1 0 2 2
    12x5: 1 0 1 0 3 2
  DATA

  def test_parse_presents_and_trees
    parser = Parser.new(INPUT)

    assert_equal 6, parser.presents.size
    assert_equal 3, parser.trees.size
  end
end
