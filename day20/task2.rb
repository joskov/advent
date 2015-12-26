require 'active_support/all'

input = 34_000_000

@houses = {}

i = 1
max_i = 0
max = 0

loop do
  (1..50).each do |j|
    @houses[i * j] = (@houses[i * j] || 0) + i * 11
  end

  result = @houses[i]
  @houses.delete(i)

  if max < result
    max_i = i
    max = result
    print "New Max - House #{i} got #{result} presents.\n"
  end

  if result > input
    print "House #{i} got #{result} presents.\n"
    break
  end
  i += 1
end
