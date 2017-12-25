require "concurrent"

def input
  pairs = $stdin.readlines.map { |line| line.strip.split("/").map(&:to_i).sort }.sort
end

class Bridge
  include Concurrent::Async

  def initialize(start, parts, foreman)
    super()
    @path = start
    @parts = parts
    @foreman = foreman
  end

  def next_parts
    # @parts.select { |pair| pair.include? @start.last }
    connection = @start.last
    @parts.map { |pair| [connection] + (pair - [connection]) if pair.include? connection }.compact
  end

  def build
    h, *tail = next_parts
    @path += h
  end
end  
