Point = Data.define(:x, :y) do
  def area(other)
    ((other.x - x).abs + 1) * ((other.y - y).abs + 1)
  end
end
