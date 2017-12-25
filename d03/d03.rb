def _d31_
  num = gets.to_i
  ring = (Math.sqrt(num-1).floor/2.0).ceil
  side_length = ring * 2 + 1
  ring + ((num - 1) % (side_length - 1) - (side_length/2.0).floor).abs
end
