require 'active_support/all'

data = File.read('input.txt')

coordinates = [0, 0]
houses_visited = { coordinates => 1 }
data.each_char do |char|
  case char
  when '<'
    coordinates[0] -= 1
  when '>'
    coordinates[0] += 1
  when '^'
    coordinates[1] -= 1
  when 'v'
    coordinates[1] += 1
  else
    print 'ERROR'
  end
  old = houses_visited[coordinates] || 0
  houses_visited[coordinates] = old + 1
end

print "Total Houses Visited: #{houses_visited.length}\n"
