require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test.txt')

lines.map!(&:to_i)
required = lines.sum / 3

print lines
print "\n"

def self.left(numbers, required)
  (1..(numbers.count / 2)).each do |combo|
    numbers.combination(combo).each do |i|
      return true if i.sum == required
    end
  end
  false
end

(1..(lines.count / 3)).each do |combo|
  print "#{combo}\n"
  list = []
  lines.combination(combo).each do |i|
    next if i.sum != required
    next unless left(lines - i, required)
    list << i
  end
  next if list.empty?
  list.map! do |item|
    item.reduce(1, :*)
  end
  print "Result is: #{list.min}\n"
  break
end
