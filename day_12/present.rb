require "matrix"

Present = Data.define(:matrix) do
  INPUT_MATCH = /[^\d]+/m

  def self.build_from(lines)
    match = lines.match(INPUT_MATCH)
    return unless match && match[0].strip != ""

    new(Matrix.rows(match[0].split.map { |line| translate_line(line) }))
  end

  def self.translate_line(line)
    line.chars.map { |char| char == "#" ? 1 : 0 }
  end

  def full_area
    matrix.row_count * matrix.column_count
  end

  def minimal_area
    matrix.to_a.flatten.sum
  end
end
