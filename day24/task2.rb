require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test.txt')

lines.map!(&:to_i)
required = lines.sum / 4

print lines
print "\n"

def self.left(numbers, required, parts)
  return true if parts == 1
  (1..(numbers.count / parts)).each do |combo|
    numbers.combination(combo).each do |i|
      next unless i.sum == required
      return true if left(numbers - i, required, parts - 1)
    end
  end
  false
end

(1..(lines.count / 4)).each do |combo|
  print "#{combo}\n"
  list = []
  lines.combination(combo).each do |i|
    next if i.sum != required
    next unless left(lines - i, required, 3)
    list << i
  end
  next if list.empty?
  list.map! do |item|
    item.reduce(1, :*)
  end
  print "Result is: #{list.min}\n"
  break
end
