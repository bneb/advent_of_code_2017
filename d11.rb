def _d111_(input = gets.scan(/\w+/))
  steps = 0
  dirs = {
    "ne" => 0,
    "sw" => 0,
    "n"  => 0,
    "s"  => 0,
    "nw" => 0,
    "se" => 0,
  }

  dir_ops = {
    "ne" => "sw",
    "sw" => "ne",
    "n"  => "s",
    "s"  => "n",
    "nw" => "se",
    "se" => "nw",
  }

  dir_changes = {
    "ne" => { "nw" => "n",  "s"  => "se" },
    "n"  => { "sw" => "nw", "se" => "ne" },
    "nw" => { "ne" => "n",  "s"  => "sw" },
    "sw" => { "n"  => "nw", "se" => "s" },
    "s"  => { "nw" => "sw", "ne" => "se" },
    "se" => { "n"  => "ne", "sw" => "s" },
  }

  input.each { |d| dirs[d] += 1 }

  last_vals = nil

  until last_vals == dirs.values do
    last_vals = dirs.values

    dirs.each do |dir, dir_steps|
      op_dir = dir_ops[dir]
      op_steps = dirs[op_dir]

      canceled_steps = [dir_steps, op_steps].min

      dirs[dir] -= canceled_steps
      dirs[op_dir] -= canceled_steps
    end

    dirs.each do |dir, dir_steps|
      dir_changes[dir].each do |ch_dir, new_dir|
        ch_steps = dirs[ch_dir]
        
        canceled_steps = [dir_steps, ch_steps].min

        dirs[dir] -= canceled_steps
        dirs[ch_dir] -= canceled_steps
        dirs[new_dir] += canceled_steps
      end
    end
  end

  dirs.values.inject(&:+)
end

# puts _d111_

def _d112_
  input = gets.scan(/\w+/)
  m = 0

  (0...input.length).each do |i|
    n = _d111_(input[0..i])
    m = n if n > m
  end

  m
end

puts _d112_
