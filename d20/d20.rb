N = 10000

def input
  $stdin.readlines.map { |l| l.strip.scan(/[\d-]+/).each_slice(3).to_a }
end

def mdist(p)
  p.last.map(&:to_i).map(&:abs).inject(&:+)
end

def _d201_
  min = nil

  input.each_with_index do |particle, index|
    min = [particle, index] if min.nil? || mdist(min.first) > mdist(particle)
  end

  min.last
end

# puts _d201_

class Particle
  def initialize(p, v, a)
    @p = p.map(&:to_i)
    @v = v.map(&:to_i)
    @a = a.map(&:to_i)
  end

  def move
    @v.length.times { |i| @v[i] += @a[i] }
    @p.length.times { |i| @p[i] += @v[i] }
  end

  def key
    @p.join
  end
end


def _d202_
  particles = {}

  input.each do |p|
    particle = Particle.new(*p)
    particles[particle.key] = (particles[particle.key] || []) << particle
  end

  N.times do
    next_particles = {}

    particles.values.each do |ps|
      ps.each do |p|
        p.move
        k = p.key

        next_particles[k] = (next_particles[k] || []) << p
      end
    end

    particles = next_particles

    particles.each { |k, v| particles.delete(k) if v.length > 1 }
  end
  particles.length
end

puts _d202_
