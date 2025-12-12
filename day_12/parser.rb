require_relative "present"
require_relative "tree"

class Parser
  attr_reader :presents, :trees

  def initialize(input)
    @presents = parse_presents(input)
    @trees = parse_trees(input)
  end

  private

  def parse_presents(input)
    input.split(":").filter_map do |section|
      Present.build_from(section)
    end
  end

  def parse_trees(input)
    input.split("\n").filter_map do |section|
      Tree.build_from(section, @presents)
    end
  end
end
