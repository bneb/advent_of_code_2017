class CPU
  def instructions
    instructions = []

    while instruction = gets.strip
      break if instruction.empty? || instruction.nil?
      instructions << instruction.strip.scan(/[\w-]+/)
    end

    instructions
  end

  def initialize(n = 1, registers = {})
    @instructions = instructions
    @programs = (0..n).map { |pid| Program.new(pid, @instructions, self, registers) }
  end

  def message(pid, value)
    @programs[(pid + 1) % @programs.length].enqueue(value)
  end

  def run_all
    until @programs.all? { |p| p.on_hold? }
      # sleep 0.2
      @programs.map(&:process_instruction)
    end

    return @programs.map do |p|
      [
        "pid: #{p.id}",
        "messages_sent: #{p.number_of_messages_sent}",
        "mul_operations: #{p.number_of_mul_operations}",
        "registers:",
        p.mem,
      ]
    end
  end
end

class Program
  def initialize(p, instructions, cpu, registers = {})
    @pid = p
    @registers = Hash.new(0).update("p" => p).update(registers)
    @instructions = instructions
    @index = 0
    @sent = 0
    @mul = 0
    @queue = []
    @waiting = false
    @cpu = cpu
  end

  def id
    @pid
  end

  def mem
    @registers
  end

  def value(x)
    @registers.fetch(x, x.to_i)
  end

  def on_hold?
    @waiting && @queue.empty?
  end

  def number_of_messages_sent
    @sent
  end

  def number_of_mul_operations
    @mul
  end

  def enqueue(message)
    @queue << message
  end

  def process_instruction
    if @index >= @instructions.length
      @waiting = true
      return
    end

    i, x, y = @instructions[@index]
    # print "instruction: ", i, " ", x, " ", y, "\n"
    # print @registers, "\n"

    case i
    when "snd"
      @cpu.message(@pid, value(x))
      @sent += 1
    when "set"
      @registers[x] = value(y)
    when "add"
      @registers[x] += value(y)
    when "sub"
      @registers[x] -= value(y)
    when "mul"
      @registers[x] *= value(y)
      @mul += 1
    when "div"
      @registers[x] /= value(y)
    when "mod"
      @registers[x] %= value(y)
    when "rcv"
      if m = @queue.shift
        @registers[x] = m
        @waiting = false
      else
        @waiting = true
        return
      end
    when "jgz"
      if value(x) > 0
        j = value(y) - 1
        puts "\n\tjumping from #{@index} to #{@index+j+1}\n\n"
        @index += j
      end
    when "jnz"
      if value(x) != 0
        j = value(y) - 1
        puts "\n\tjumping from #{@index} to #{@index+j+1}\n\n"
        @index += j
      end
    end

    @index += 1
  end
end

# puts CPU.new.run_all
