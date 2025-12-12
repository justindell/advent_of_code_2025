require "matrix"

Tree = Data.define(:width, :length, :presents) do
  def self.build_from(line, presents)
    return unless line.include?("x")

    area, amounts = line.split(":").map(&:strip)
    width, length = area.split("x").map(&:to_i)
    presents = build_presents(amounts, presents)
    new(width, length, presents)
  end

  def self.build_presents(amounts, presents)
    collection = []
    amounts.split.each_with_index do |amount, index|
      amount.to_i.times { collection << presents[index.to_i] }
    end
    collection
  end

  def easy_fit?
    present_full_area <= area
  end

  def wont_fit?
    present_minimal_area > area
  end

  private

  def present_full_area
    presents.sum { |present| present.full_area }
  end

  def present_minimal_area
    presents.sum { |present| present.minimal_area }
  end

  def area
    width * length
  end
end
