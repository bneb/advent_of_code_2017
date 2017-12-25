N = 16.freeze

def swap!(a, x, y)
  t = a[x]
  a[x] = a[y]
  a[y] = t

  a
end

def _d161_(chars = (0...N).map { |i| (97+i).chr }, instructions = gets.split(","))
  instructions.each do |i|
    t = i[0]
    x, y = i[1..-1].scan(/\w+/)
    case t
    when "s"
      chars = chars.pop(x.to_i) + chars
    when "x"
      swap!(chars, x.to_i, y.to_i)
    when "p"
      pos1 = chars.index(x)
      pos2 = chars.index(y)
      swap!(chars, pos1, pos2)
    end
  end

  chars
end

# print _d161_.join, "\n"

def _d162_(chars = (0...N).map { |i| (97+i).chr }, instructions = gets.split(","))
  c = chars.dup
  n = 1000000000
  i = 0
  while i < n
    n = i + (n % i) if i > 0 && chars == c
    chars = _d161_(chars, instructions)
    i += 1
  end
  chars
end

puts _d162_.join
