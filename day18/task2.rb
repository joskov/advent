require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test.txt')

OFFSETS = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]

def self.set(lamps, x, y)
  lamps[[x, y]] = true
end

def self.check(lamps, x, y)
  lamps[[x, y]]
end

def self.neighboring(lamps, x, y)
  result = 0
  OFFSETS.each do |offset_x, offset_y|
    result += 1 if check(lamps, x + offset_x, y + offset_y)
  end
  result
end

def self.turn_on_corners(lamps)
  set(lamps, 0, 0)
  set(lamps, @columns - 1, 0)
  set(lamps, 0, @rows - 1)
  set(lamps, @columns - 1, @rows - 1)
end

def self.iterate(lamps)
  result = {}
  turn_on_corners(result)
  @rows.times do |y|
    @columns.times do |x|
      current = check(lamps, x, y)
      neighbors = neighboring(lamps, x, y)
      if current
        set(result, x, y) if neighbors == 2 || neighbors == 3
      else
        set(result, x, y) if neighbors == 3
      end
    end
  end
  result
end

def self.print_lamps(lamps)
  @rows.times do |y|
    @columns.times do |x|
      print check(lamps, x, y) ? '#' : '.'
    end
    print "\n"
  end
end

lamps = {}
lines.each_with_index do |line, y|
  line.strip!
  line.split(//).each_with_index do |char, x|
    set(lamps, x, y) if char == '#'
  end
end
@rows = lines.count
@columns = lines.first.length
turn_on_corners(lamps)

100.times do |i|
  print "Iteration #{i}\n"
  lamps = iterate(lamps)
end

print_lamps(lamps)
print "Lamps ON: #{lamps.count}\n"
