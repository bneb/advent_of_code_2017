def update(layers, positions, directions)
  layers.each do |l, depth|
    case positions[l]
    when 0
      directions[l] = 1
    when depth-1
      directions[l] = -1
    end

    positions[l] += directions[l]
  end

  [positions, directions]
end

def _inputs_
  layers = {}
  positions = {}
  directions = {}

  while input = gets
    break if input.empty? || input.strip == ""
    input = input.scan(/\w+/).map(&:to_i)
    l = input.first
    layers[l] = input.last
    positions[l] = 0
  end

  [layers, positions, directions]
end


def _d131_(check_0, layers, positions, directions)
  cost = 0

  (0..layers.keys.max).each do |l|
    depth = layers[l]

    if depth && positions[l] == 0
      if l == 0 && check_0
        cost += depth
      else
        cost += l * depth
      end
    end

    positions, directions = update(layers, positions, directions)
  end

  cost
end

# puts _d131_(false, *_inputs_)

def _d132_(layers = _inputs_.shift, i = 0)
  i += 1 while layers.any? { |l, depth| (i+l) % (2*depth - 2) == 0 }
  i
end

puts _d132_
