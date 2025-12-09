class Circuits
  Circuit = Struct.new(:connections) do
    def add(connection)
      connections << connection
    end

    def contains?(box)
      connections.any? { |conn| conn.contains?(box) }
    end

    def boxes
      connections.flat_map(&:boxes).uniq
    end
  end

  attr_reader :circuits

  def initialize
    @circuits = []
  end

  def add(connection)
    circuits = find_circuits_for(connection)

    if circuits.size == 2
      circuits[0].add(connection)
      circuits[1].connections.each do |conn|
        circuits[0].add(conn)
      end
      @circuits.delete(circuits[1])
    elsif circuits.size == 1
      circuits[0].add(connection)
    else
      @circuits << Circuit.new([ connection ])
    end
  end

  def size = circuits.size
  def [](index) = circuits[index]
  def map(&block) = circuits.map(&block)

  private

  def find_circuits_for(connection)
    @circuits.select do |circuit|
      circuit.contains?(connection.box_a) || circuit.contains?(connection.box_b)
    end
  end
end
