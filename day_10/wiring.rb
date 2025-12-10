class Wiring < Data.define(:connections)
  def self.build_from(str)
    connections = str.scan(/[\d,]+/).map do |match|
      match.split(',').map(&:to_i)
    end
    new(connections)
  end

  def count = connections.size
  def [](index) = connections[index]
end
