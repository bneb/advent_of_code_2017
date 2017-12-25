def input
  $stdin.readlines.map { |line| line.strip.split(" => ") }
end

def to_grid(s)
  s.split("/").map { |row| row.split("") }
end

def fliph(pattern)
  pattern.map { |row| row.reverse }
end

def flipv(pattern)
  pattern.reverse
end

def rotate(pattern)
  rows = pattern.length - 1
  cols = pattern.first.length - 1

  (0..rows).map { |i| (0..cols).map { |j| pattern[rows-j][i] } }
end

def all_patterns(pattern)
  res = [pattern]

  3.times do
    res << rotate(pattern)
  end

  res += res.map { |pattern| fliph(pattern) }
  res += res.map { |pattern| flipv(pattern) }

  res
end

def form_image(rows)
  lines = {}

  row_num = 0
  rows.each do |row|
    cell_len = 0
    row.each do |cell|
      cell_len = cell.length
      cell.each_with_index do |cell_row, index|
        line_num = row_num + index
        lines[line_num] = lines.fetch(line_num, []) + cell_row
      end
    end
    row_num += cell_len
  end

  lines.values
end

def next_image(image, patterns)
  slice_size = (image.length % 2 == 0 ? 2 : 3)
  image_rows = []
  image.each_slice(slice_size) do |rows|
    cells = []
    rows.first.length.times.each_slice(slice_size) do |cols|
      cells << rows.map { |r| r[cols.first..cols.last] }
    end
    image_rows << cells.map { |c| patterns[c] }
  end

  form_image(image_rows)
end

def _d121_(n)
  image = ".#. ..# ###".split(" ").map { |l| l.split("") }

  patterns = {}

  input.each do |pattern, rule|
    all_patterns(to_grid(pattern)).each { |p| patterns[p] = to_grid(rule) }
  end

  n.times { image = next_image(image, patterns) }

  image.map { |r| r.select { |i| i == "#" }.length }.inject(&:+)
end

# puts _d121_(5)

def _d122_
  _d121_(18)
end

puts _d122_
