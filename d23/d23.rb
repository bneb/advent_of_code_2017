require_relative "../d18/d182"

def _d231_
  cpu = CPU.new(0)
  cpu.run_all
end

# puts _d231_

def is_prime?(n)
  (2..Math.sqrt(n).to_i).each do |d|
    return false if n % d == 0
  end

  true
end

def _d232_(b, c, delta)
  h = 0

  while b <= c do
    h += 1 unless is_prime? b
    b += delta
  end
  
  h
end

puts _d232_(105700, 122700, 17)
