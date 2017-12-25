require "concurrent"

def _d151_(n = 40000000, a_mul = 16807, b_mul = 48271, modulus = 2147483647, nbits=16)
  a = gets.scan(/\d+/).first.to_i
  b = gets.scan(/\d+/).first.to_i

  count = 0
  bitwise = (2 ** nbits) - 1

  n.times do
    a = ((a*a_mul) % modulus)
    b = ((b*b_mul) % modulus)

    count += 1 if (a & bitwise) == (b & bitwise)
  end

  count
end

# puts _d151_

class D15
  include Concurrent::Async

  def initialize
    super()
    @nums = []
  end

  def get_index(n)
    @nums[n]
  end

  def generate(n, mul, mod, mod_check, total = 5000000)
    while @nums.length < total
      n = ((n*mul) % mod)
      @nums << n if n % mod_check == 0
    end
  end
end

def _d152_(n = 5000000, a_mul = 16807, a_mod = 4, b_mul = 48271, b_mod = 8, modulus = 2147483647, nbits=16)
  a = gets.scan(/\d+/).first.to_i
  b = gets.scan(/\d+/).first.to_i

  count = comparisons = 0

  bitwise = (2 ** nbits) - 1

  a_gen = D15.new
  b_gen = D15.new

  a_gen.async.generate(a, a_mul, modulus, a_mod)
  b_gen.async.generate(b, b_mul, modulus, b_mod)

  until comparisons == n
    a = a_gen.get_index(comparisons)
    b = b_gen.get_index(comparisons)
    if a && b
      count += 1 if (a & bitwise) == (b & bitwise)
      comparisons += 1
    end
  end

  count
end

puts _d152_
