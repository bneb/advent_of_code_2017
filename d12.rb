def _d121_
  nodes = {}

  while input = gets
    break if input == "\n"

    input = input.scan(/\w+/).map(&:to_i)

    n = input.shift
    nodes[n] = input - [n]
  end

  next_nodes = nodes[0]
  network = [0] + next_nodes

  until next_nodes.empty?
    n = next_nodes.shift
    next_nodes += nodes[n] - network
    network += nodes[n] - network
  end

  network.length
end

# puts _d121_

def _d122_
  nodes = {}
  networks = []

  while input = gets
    break if input == "\n" || input == "" || input.empty?

    input = input.scan(/\w+/).map(&:to_i)

    n = input.shift
    nodes[n] = input - [n]
  end

  l = nodes.keys

  until l.empty?
    val = l.shift
    next_nodes = nodes[val]
    network = [val] + next_nodes

    until next_nodes.empty?
      n = next_nodes.shift
      next_nodes += nodes.fetch(n, []) - network
      network += nodes.fetch(n, []) - network
    end

    networks << network
    l = l - network
  end

  networks.length
end

puts _d122_
