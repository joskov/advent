require 'active_support/all'

lookup = { row: 2978, column: 3083 }

code = 20_151_125
coordinates = { row: 1, column: 1 }

def self.next_coordinates(coordinates)
  if coordinates[:row] == 1
    coordinates[:row] = coordinates[:column] + 1
    coordinates[:column] = 1
  else
    coordinates[:row] -= 1
    coordinates[:column] += 1
  end
  coordinates
end

def self.iterate(code)
  (code * 252_533) % 33_554_393
end

loop do
  code = iterate(code)
  next_coordinates(coordinates)
  next unless coordinates == lookup
  print "#{coordinates}\n"
  print "#{code}\n"
  break
end
