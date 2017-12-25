LEFT = [0, -1].freeze
RIGHT = [0, 1].freeze
UP = [-1, 0].freeze
DOWN = [1, 0].freeze

DIRS = [UP, RIGHT, DOWN, LEFT].freeze

def input
  raw_grid = $stdin.readlines.map { |line| line.strip.split("") }
  grid = Hash.new(".")

  raw_grid.each_with_index do |row, row_num|
    row.each_with_index do |col, col_num|
      grid[[row_num, col_num]] = col
    end
  end

  grid
end

def print_grid(grid)
  l = grid.keys.map { |k| k.last }.min
  u = grid.keys.map { |k| k.first }.min
  r = grid.keys.map { |k| k.last }.max
  d = grid.keys.map { |k| k.first }.max

  puts "-" * 42
  (u..d).each do |row|
    line = ""
    (l..r).each do |col|
      line += " #{grid[[row, col]]} "
    end
    puts line
  end
end

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

def change_direction(val, dir)
  case val
  when "."
    return DIRS[(DIRS.index(dir) - 1) % DIRS.length]
  when "W"
    return dir
  when "#"
    return DIRS[(DIRS.index(dir) + 1) % DIRS.length]
  when "F"
    return DIRS[(DIRS.index(dir) + 2) % DIRS.length]
  end

  puts "oh no! #{val}"
end

def update_node(val)
  case val
  when "."
    return "W"
  when "W"
    return "#"
  when "#"
    return "F"
  when "F"
    return "."
  end

  puts "oh no! #{val}"
end

def _d221_(n)
  grid = input 
  new_infections = 0

  pos = [
    grid.keys.map { |k| k.first }.max/2,
    grid.keys.map { |k| k.last }.max/2,
  ]

  dir = UP

  n.times do
    dir = change_direction(grid[pos], dir)
    grid[pos] = update_node(grid[pos])
    new_infections += 1 if grid[pos] == "#"
    pos = move(pos, dir)
  end

  new_infections
end

# puts _d221_

def _d222_
  _d221_(10000000)
end

puts _d222_
