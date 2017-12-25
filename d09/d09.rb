def _d91_
  input = gets

  score = 1
  total = i = 0
  gar = false

  while i < input.length
    c = input[i]

    if gar
      case c
      when "!"
        i += 1
      when ">"
        gar = false
      end
    else
      case c
      when "<"
        gar = true
      when "{"
        total += score
        score += 1
      when "}"
        score -= 1
      end
    end

    i += 1
  end

  total
end

# puts _d91_

def _d92_
  input = gets

  total = i = 0
  gar = false

  while i < input.length
    c = input[i]

    if gar
      case c
      when "!"
        i += 1
      when ">"
        gar = false
      else
        total += 1
      end
    elsif c == "<"
      gar = true
    end

    i += 1
  end

  total
end

puts _d92_
