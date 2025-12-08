class TachyonLine
  BeamProcessor = Data.define(:position, :index) do
    def calculate
      return index if position == "."
      [ index - 1, index + 1 ] if split?
    end

    def split? = position == "^"
  end

  attr_reader :splits, :line

  def initialize(line:, beams: [])
    @line = line
    @beams = beams
    @splits = []
  end

  def calculate_beam_positions
    @line.chars.each_with_index.filter_map do |position, index|
      next unless @beams.include?(index)

      BeamProcessor.new(position, index).tap do |processor|
        @splits << index if processor.split?
      end.calculate
    end.flatten.uniq
  end
end

class TaychonLineProcessor
  attr_reader :current_line, :raw_line, :next_line

  def initialize(current_line, raw_line)
    @current_line = current_line
    @raw_line = raw_line
    @next_line = Array.new(@current_line.size, 0)
  end

  def process
    @raw_line.chars.each_with_index do |symbol, index|
      @next_line[index] += @current_line[index] if symbol == "."
      if symbol == "^"
        @next_line[index - 1] += @current_line[index]
        @next_line[index + 1] += @current_line[index]
      end
    end
    @next_line
  end
end

class Tachyon
  Status = Data.define(:beams, :splits)

  def initialize(input)
    @input = input
    @status = Status.new([ start ], [])
    @values = setup_values
  end

  def total_splits
    @input[1..-1].inject(@status) do |status, line|
      tachyon_line = TachyonLine.new(line:, beams: status.beams)
      Status.new(tachyon_line.calculate_beam_positions, status.splits + tachyon_line.splits)
    end.splits.count
  end

  def total_timelines
    @input[1..-1].each do |line|
      processor = TaychonLineProcessor.new(@values, line.chomp)
      @values = processor.process
    end
    @values.sum
  end

  private

  def start = @input.first.index("S")

  def setup_values
    Array.new(@input.size, 0).tap { |values| values[start] = 1 }
  end
end
