require 'active_support/all'

data = File.read('input.txt')

count = 0
coordinates = [0, 0]
coordinates_r = [0, 0]
# houses_visited = { coordinates => 2 }
houses_visited = [coordinates]

data.each_char do |char|
  # next unless ['>', '<', '^', 'v'].include?(char)
  if count.even?
    using = coordinates
    # print 'Santa'
  else
    using = coordinates_r
    # print 'Robo'
  end

  case char
  when '<'
    using[0] -= 1
  when '>'
    using[0] += 1
  when '^'
    using[1] -= 1
  when 'v'
    using[1] += 1
  else
    print 'ERROR'
  end
  # print using

  houses_visited << using.dup
  count += 1
end
houses_visited.uniq!
print "Total Houses Visited: #{houses_visited.length}\n"
