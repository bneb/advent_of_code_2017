class D18
	include Concurrent::Async

	def initialize(p, instructions, runner)
		super()
		@p = p
		@instructions	= instructions
		@registers = Hash.new(0).update("p" => p)
		@index = 0
		@messages = []
		@message_count = 0
		@runner = runner
    @waiting = false
	end

	def get_message
		@message_count += 1
		@messages[@message_count-1]
	end

  def waiting?
    @waiting
  end

  def show
    print "program: ", @p, "\n"
  end

	def generate
    print "program: ", @p, " called generate \n"
    binding.pry
		while @index < @instructions.length do
			i, x, y = @instructions[@index]

			print ["program:", @p, i, x, y, @messages[-3..-1], @messages.length, "\n"].join(" ")

			case i
			when "snd"
				@messages << @registers.fetch(x, x.to_i)
			when "set"
				@registers[x] = @registers.fetch(y, y.to_i)
			when "add"
				@registers[x] += @registers.fetch(y, y.to_i)
			when "mul"
				@registers[x] *= @registers.fetch(y, y.to_i)
			when "mod"
				@registers[x] %= @registers.fetch(y, y.to_i)
			when "rcv"
        until m = @runner.get_message(@p)
          if @runner.all_waiting?(@p)
            @runner.exit
            return
          end
          @waiting = true
        end
        @waiting = false
        @registers[x] = m
			when "jgz"
				@index += @registers.fetch(y, y).to_i - 1 if @registers.fetch(x, x).to_i > 0
			end

			@index += 1
		end
	end

  def messages_sent
    @message_count
  end
end

class Runner
	def initialize
		instructions = []

		while instruction = gets.strip
			break if instruction.empty? || instruction.nil?
			instructions << instruction.strip.scan(/[\w-]+/)
		end

		@programs = [D18.new(0, instructions.dup, self), D18.new(1, instructions, self)]
	end

	def run
		@programs.each do |p|
      p.show
      p.async.generate
    end
    @programs[1].messages_sent
	end

	def get_message(p)
    @programs[(p+1) % 2].get_message
	end

  def all_waiting?(p)
    (@programs[0...p] + @programs[(p+1)..-1]).all? { |x| x.waiting? }
  end

  def exit
    puts @programs[1].messages_sent
    @programs[1].messages_sent
  end
end

def _d182_
  Runner.new.run
end

puts _d182_
