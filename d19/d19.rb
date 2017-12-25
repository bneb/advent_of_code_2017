DOWN = [1, 0].freeze
UP = [-1, 0].freeze
RIGHT = [0, 1].freeze
LEFT = [0, -1].freeze

def input
  $stdin.readlines.map { |line| line.split("") }
end

def val(grid, pos)
  grid[pos[0]][pos[1]]
end

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

def test(grid, pos, dir)
  lrpat = /[\w-]/
  udpat = /[\w\|]/

  case dir
  when DOWN
    return RIGHT if val(grid, move(pos, RIGHT)) =~ lrpat
    return LEFT if val(grid, move(pos, LEFT)) =~ lrpat
  when UP
    return RIGHT if val(grid, move(pos, RIGHT)) =~ lrpat
    return LEFT if val(grid, move(pos, LEFT)) =~ lrpat
  when RIGHT
    return DOWN if val(grid, move(pos, DOWN)) =~ udpat
    return UP if val(grid, move(pos, UP)) =~ udpat
  when LEFT
    return DOWN if val(grid, move(pos, DOWN)) =~ udpat
    return UP if val(grid, move(pos, UP)) =~ udpat
  end
end

def _d191_
  count = 0
  grid = input
  pos = [0, grid.first.index("|")]
  dir = DOWN
  letters = ""

  loop do
    path = val(grid, pos)
    case path
    when " "
      break
    when "+"
      dir = test(grid, pos, dir)
    when "|"
      nil
    when "-"
      nil
    else
      letters << path
    end

    count += 1
    pos = move(pos, dir)
  end

  [letters, count]
end

puts _d191_
