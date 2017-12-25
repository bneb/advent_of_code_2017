def _d171_(step = gets.strip.to_i)
  l = [0]
  i = 0

  (1..2017).each do |n|
    i = (i + step) % l.length + 1
    l = l[0...i] + [n] + (l[i..-1] || [])
  end

  l[l.index(2017)+1]
end

# print _d171_, "\n"

def _d172_(step = gets.strip.to_i)
  i = k = 0
  (1..50000000).each do |n|
    i = (i + step) % n + 1
    if i == 1
      k = n
    end
  end

  k
end

puts _d172_
