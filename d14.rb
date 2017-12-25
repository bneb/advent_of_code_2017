require_relative "d10"

def _inputs_
  s = gets.strip
  (0..127).map { |i| s + "-" + i.to_s }
end

def _hash_inputs_
  _inputs_.map { |k| _d102_(k) }
end

def _d141_
  _hash_inputs_.map { |h| h.each_char.map { |c| c.to_i(16).to_s(2).rjust(4, "0") }.join }
end

# puts _d141_.map { |r| r.each_char.map(&:to_i).inject(&:+) }.inject(&:+)

def _d142_
  File.open("d142.txt", "w")
  File.open("d1422.txt", "w")
  grid = _d141_
  grid.each_with_index do |r, rn|
    File.open("d1422.txt", "a") { |f| f.write(r + "\n") }
    File.open("d142.txt", "a") { |f| f.write("") }
    r.split("").each_with_index do |c, cn|
      str_rep = "#{rn.to_s.rjust(3, "0")}#{cn.to_s.rjust(3, "0")}"

      if c == "1"
        line = str_rep + " => " + str_rep if c == "1"

        if rn < 127 && grid[rn+1][cn] == "1" # down 1
          line += ", #{(rn+1).to_s.rjust(3, "0")}#{cn.to_s.rjust(3, "0")}"
        end
        if rn > 0 && grid[rn-1][cn] == "1" # up 1
          line += ", #{(rn-1).to_s.rjust(3, "0")}#{cn.to_s.rjust(3, "0")}"
        end
        if cn < 127 && grid[rn][cn+1] == "1" # right 1
          line += ", #{rn.to_s.rjust(3, "0")}#{(cn+1).to_s.rjust(3, "0")}"
        end
        if cn > 0 && grid[rn][cn-1] == "1" # left 1
          line += ", #{rn.to_s.rjust(3, "0")}#{(cn-1).to_s.rjust(3, "0")}"
        end

        File.open("d142.txt", "a") { |f| f.write(line + "\n") }
      end
    end
  end

  `ruby d12.rb < d142.txt`
end

puts _d142_
