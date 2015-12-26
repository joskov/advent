require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test.txt')

REQUIRED_SIZE = 150
# REQUIRED_SIZE = 25

@containers = []
lines.each do |line|
  @containers << line.to_i
end
@containers_count = @containers.count

def self.working_combinations(size)
  result = 0
  @containers.combination(size).each do |combination|
    result += 1 if combination.sum == REQUIRED_SIZE
  end
  result
end

result = 0
(1..(@containers.size)).each do |size|
  print "#{size}\n"
  result = working_combinations(size)
  break if result > 0
end

print "#{@containers}\n#{result}\n"
