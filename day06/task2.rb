require 'active_support/all'

# Utils
class Utils
  def self.coordinates(line)
    x1, y1, x2, y2 = line.split(/[a-z\s,]/).reject(&:empty?).map(&:to_i)
    (x1..x2).to_a.product((y1..y2).to_a)
  end

  def self.turn_on(grid, coordinate)
    old = grid[coordinate] || 0
    grid[coordinate] = old + 1
  end

  def self.turn_off(grid, coordinate)
    old = grid[coordinate] || 0
    grid[coordinate] = [old - 1, 0].max
  end

  def self.toggle(grid, coordinate)
    old = grid[coordinate] || 0
    grid[coordinate] = old + 2
  end
end

lines = File.readlines('input.txt')

grid = {}
lines.each do |line|
  coordinates = Utils.coordinates(line)
  if line.starts_with?('turn on ')
    coordinates.each do |coordinate|
      Utils.turn_on(grid, coordinate)
    end
  elsif line.starts_with?('turn off ')
    coordinates.each do |coordinate|
      Utils.turn_off(grid, coordinate)
    end
  elsif line.starts_with?('toggle ')
    coordinates.each do |coordinate|
      Utils.toggle(grid, coordinate)
    end
  else
    print 'ERROR'
  end
end

print "Total Turned On Lights: #{grid.values.sum}\n"
