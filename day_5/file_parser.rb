class FileParser
  def initialize(file_path)
    @lines = File.readlines(file_path).map(&:chomp)
  end

  def fresh_ranges          = @lines[0...empty_line_index]
  def available_ingredients = @lines[(empty_line_index + 1)..-1]

  private

  def empty_line_index
    @lines.index { |line| line.strip.empty? }
  end
end
