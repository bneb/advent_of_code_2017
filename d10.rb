def rev(nums, current_pos, l)
  (0...l/2).each do |i|
    lpos = (current_pos + i) % nums.length
    rpos = (current_pos + l-1 - i) % nums.length

    temp = nums[lpos]

    nums[lpos] = nums[rpos]
    nums[rpos] = temp
  end
  nums
end

def _d101_(nums = (0..255).to_a, lengths = gets.scan(/\w+/).map(&:to_i), pos=0, skip=0)
  lengths.each do |l|
    nums = rev(nums, pos, l)
    pos = (pos + l + skip) % nums.length
    skip += 1
  end

  [nums, pos, skip]
end

# a, b = _d101_.shift(2)
# puts a*b

def _d102_(lengths = gets)
  lengths = lengths.strip.each_byte.to_a + [17, 31, 73, 47, 23]
	nums = (0..255).to_a
	pos = skip = 0

	64.times { nums, pos, skip = _d101_(nums, lengths, pos, skip) }

	(0..15).map { |i| nums.slice(i*16, 16).inject(&:^).to_s(16).rjust(2, "0") }.inject(&:+)
end

# puts _d102_
