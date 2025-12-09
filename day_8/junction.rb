require_relative "connection"
require_relative "circuits"

class Junction
  attr_reader :connections

  def initialize(boxes)
    @boxes = boxes
    @connections = setup_possible_connections
    @circuits = Circuits.new
  end

  def wire_closest_connection
    connection = closest_new_connection.wire
    @circuits.add(connection)
    check_if_everything_is_connected(connection)
  end

  def circuit_sizes
    @circuits.map { |circuit| circuit.boxes.size }
  end

  def closest_new_connection
    @connections.reject(&:wired).min_by(&:distance)
  end

  private

  def setup_possible_connections
    @boxes.flat_map do |box|
      create_connections_for(box)
    end.uniq
  end

  def create_connections_for(box)
    @boxes.filter_map do |other_box|
      next if box == other_box

      Connection.new(box, other_box)
    end
  end

  def check_if_everything_is_connected(connection)
    if @circuits.size == 1 && @circuits[0].boxes.size == @boxes.size
      puts
      puts "All boxes are connected!"
      puts connection.distance_from_wall
      exit
    end
  end
end
