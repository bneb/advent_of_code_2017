require 'concurrent'
require 'pry'

def _d181_
  last_sound = nil

  instructions = []
  while instruction = gets.strip
    break if instruction.empty? || instruction.nil?
    instructions << instruction.strip.scan(/[\w-]+/)
  end

  registers = Hash.new(0)
  index = 0

  while index < instructions.length do
    i, x, y = instructions[index]

    case i
    when "snd"
      last_sound = registers.fetch(x, x).to_i
    when "set"
      registers[x] = registers.fetch(y, y).to_i
    when "add"
      registers[x] += registers.fetch(y, y).to_i
    when "mul"
      registers[x] *= registers.fetch(y, y).to_i
    when "mod"
      registers[x] %= registers.fetch(y, y).to_i
    when "rcv"
      unless x == 0
        puts last_sound
        break
      end
    when "jgz"
      index += registers.fetch(y, y).to_i - 1 if registers.fetch(x, x).to_i > 0
    end

    index += 1
  end

  last_sound
end

# puts _d181_

def _d182_
  instructions = []

  while instruction = gets.strip
    break if instruction.empty? || instruction.nil?
    instructions << instruction.strip.scan(/[\w-]+/)
  end

	queues = { 0 => [], 1 => [] }

	registers = {
		0 => Hash.new(0).update("p" => 0),
		1 => Hash.new(0).update("p" => 1),
	}

  p = 0

	counts = { 0 => 0, 1 => 0 }

	indexes = { 0 => 0, 1 => 0 }

  while indexes.values.min < instructions.length do
    if indexes[0] >= instructions.length
      return counts[1] if indexes[1] >= instructions.length
      p = 1
    elsif indexes[1] >= instructions.length do
      p = 0
    end

    i, x, y = instructions[indexes[p]]

    case i
    when "snd"
			queues[(p+1) % 2] << registers[p].fetch(x, x).to_i
			counts[p] += 1
    when "set"
      registers[p][x] = registers[p].fetch(y, y).to_i
    when "add"
      registers[p][x] += registers[p].fetch(y, y).to_i
    when "mul"
      registers[p][x] *= registers[p].fetch(y, y).to_i
    when "mod"
      registers[p][x] %= registers[p].fetch(y, y).to_i
    when "rcv"
			if queues[p].empty?
        break if queues[(p+1) % 2].empty? || indexes[(p+1) % 2] >= instructions.length
				puts "--------- switching from #{p} to #{(p+1)%2} -------------"
				puts "p: #{p}, indexes: #{indexes}, counts: #{counts}, queues: #{queues.values.each.map(&:length)}, instruction: #{instructions[indexes[p]]}"
				puts
				print "registers 0: ", registers[0], "\n"
				print "registers 1: ", registers[1], "\n"
				puts
				p = (p + 1) % 2
				next
			end
			registers[x] = queues[p].shift
    when "jgz"
      indexes[p] += registers[p].fetch(y, y).to_i - 1 if registers[p].fetch(x, x).to_i > 0
    end

    indexes[p] += 1
  end

	counts
end

puts _d182_
