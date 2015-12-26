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

def self.working_combinations(stack = [], start = 0)
  current_size = combination_size(stack)
  print "#{stack} - #{current_size}\n"
  if current_size > REQUIRED_SIZE
    return 0
  elsif current_size == REQUIRED_SIZE
    return 1
  end

  result = 0
  rest = (start..(@containers_count - 1)).to_a
  rest.each do |i|
    stack.push(i)
    result += working_combinations(stack, i + 1)
    stack.pop
  end
  result
end

def self.combination_size(combination)
  size = 0
  combination.each do |i|
    size += @containers[i]
  end
  size
end

result = working_combinations
print "#{@containers}\n#{result}\n"
