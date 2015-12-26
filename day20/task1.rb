require 'active_support/all'

input = 34_000_000

def self.divisors(number)
  result = [1, number].uniq.sum
  (2..(number / 2)).each do |i|
    result += i if number % i == 0
  end
  result
end

# i = 0
i = 2 * 3 * 5
max_i = 0
max = 0

loop do
  result = divisors(i) * 10
  if max < result
    max_i = i
    max = result
    print "New Max - House #{i} got #{result} presents.\n"
  end

  if result > input
    print "House #{i} got #{result} presents.\n"
    break
  end
  i += 2 * 3 * 5
end
