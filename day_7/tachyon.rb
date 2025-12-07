class TachyonLine
  BeamProcessor = Data.define(:position, :index) do
    def calculate
      return index if position == "."
      [ index - 1, index + 1 ] if split?
    end

    def split? = position == "^"
  end

  attr_reader :splits

  def initialize(line:, beams: [])
    @line = line
    @beams = beams
    @splits = 0
  end

  def beam_positions
    @line.chars.each_with_index.filter_map do |position, index|
      next unless @beams.include?(index)

      BeamProcessor.new(position, index).tap do |processor|
        @splits += 1 if processor.split?
      end.calculate
    end.flatten.uniq
  end
end

class Tachyon
  Status = Data.define(:beams, :splits)

  def initialize(input)
    @input = input
    @status = Status.new([ start ], 0)
  end

  def total_splits
    @input.lines[1..-1].inject(@status) do |status, line|
      tachyon_line = TachyonLine.new(line:, beams: status.beams)
      Status.new(tachyon_line.beam_positions, status.splits + tachyon_line.splits)
    end.splits
  end

  private

  def start = @input.lines.first.index("S")
end
