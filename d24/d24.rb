def input
  pairs = $stdin.readlines.map { |line| line.strip.split("/").map(&:to_i).sort }.sort
end

def get_parts(n, parts)
  parts.select { |pair| pair.include? n }
end

def _d241_
  parts = input

  starts = get_parts(0, parts)

  bridges = starts.map { |s| [s, parts - [s]] }.to_h

  next_bridges = {}

  until bridges.empty?
    last_bridges = next_bridges.dup
    next_bridges = {}

    until bridges.empty? do
      bridge, parts = bridges.shift
      connection = bridge.last
      next_pieces = get_parts(connection, parts)
      next_pieces.map do |next_piece|
        next_part = [connection, (next_piece[0] == connection ? next_piece[1] : next_piece[0])]
        next_bridges[bridge + next_part] = (parts - [next_piece])
      end
    end

    bridges = next_bridges
  end

  last_bridges.keys.map { |bridge| bridge.inject(&:+) }.max
end

puts _d241_

def _d242_

end

# puts _d42_
