class Connection
  attr_reader :box_a, :box_b, :wired

  def initialize(box_a, box_b)
    @box_a = box_a
    @box_b = box_b
    @wired = false
  end

  def eql?(other) = hash == other.hash
  def ==(other) = hash == other.hash
  def boxes = [ box_a, box_b ]

  def contains?(box)
    box == @box_a || box == @box_b
  end

  def hash
    [ box_a, box_b ].sort.hash
  end

  def distance
    @distance ||= @box_a.distance_to(@box_b)
  end

  def distance_from_wall
    @box_a.x * @box_b.x
  end

  def wire
    @wired = true
    self
  end
end
