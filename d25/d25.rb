DIRS = {
  "right" => 1,
  "left" => -1,
}

def input
  initial_state, num_steps, *lines = $stdin.readlines.map { |l| l.split }
  [
    initial_state.last[0...-1],
    num_steps[-2].to_i,
    lines.map { |l| l.empty? ? nil : l.last[0...-1] }.compact
  ]
end

def _d251_
  state, n, instructions = input

  puts "state: #{state}"
  puts "n: #{n}"
  puts "instructions: #{instructions[0..6]} ..."

  directives = {}
  instructions.each_slice(9) do |d|
    directives[[d[0], d[1].to_i]] = [d[2].to_i, d[3] == "right" ? 1 : -1, d[4]]
    directives[[d[0], d[5].to_i]] = [d[6].to_i, d[7] == "right" ? 1 : -1, d[8]]
  end

  puts "-" * 84
  directives.each { |k, v| print k, v, "\n" }
  puts "-" * 84

  tape = Hash.new(0)

  pos = 0

  n.times do
    val = tape[pos]

    next_val, move, next_state = directives[[state, val]]
    tape[pos] = next_val
    pos += move
    state = next_state
  end

  tape.values.inject(&:+)
end

puts _d251_

def _d252_

end

# puts _d252_
