class ServerRack
  def initialize(data, start:, target:, required_visits: [])
    @data = data
    @start = start
    @target = target
    @required_visits = required_visits
    @servers = build_server_hash(data)
  end

  def count_paths
    if requirement_order.empty?
      count_paths_to_target(@start)
    else
      split_by_requiements_and_multiply_paths
    end
  end

  private

  def count_paths_to_target(start)
    return 0 if start == "out"

    server = @servers[start]
    paths = server[:paths]
    return paths if paths

    server[:connections].inject(0) do |sum, connection|
      paths = sum + count_paths_to_target(connection)
      server[:paths] = paths
      paths
    end
  end

  def build_server_hash(data)
    data.each_line.to_h do |line|
      name, connections = line.strip.split(": ")
      connections = connections.split(" ")
      [ name, { connections: connections, paths: connections.include?(@target) ? 1 : nil } ]
    end
  end

  def split_by_requiements_and_multiply_paths
    (requirement_order + [ @target ]).each_with_index.inject(1) do |product, (requirement, index)|
      start = index.zero? ? @start : requirement_order[index - 1]
      paths = ServerRack.new(@data, start:, target: requirement).count_paths
      puts "Paths from #{start} to #{requirement}: #{paths}"
        product * paths
    end
  end

  def requirement_order
    @requirement_order ||= @required_visits.sort_by do |requirement|
      count_paths_to_target(requirement)
    end.reverse
  end
end
