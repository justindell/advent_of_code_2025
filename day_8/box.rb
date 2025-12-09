class Box < Data.define(:x, :y, :z)
  include Comparable

  def <=>(other)
    [ x, y, z ] <=> [ other.x, other.y, other.z ]
  end

  def distance_to(other)
    Math.sqrt((other.x - x)**2 + (other.y - y)**2 + (other.z - z)**2)
  end
end
