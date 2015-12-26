require 'active_support/all'

lines = File.readlines('input.txt')

paper = 0
ribbon = 0
lines.each do |line|
  dimensions = line.split('x').map(&:to_i)
  l, w, h = dimensions
  perimeters = [l * w, w * h, h * l]

  paper += 2 * perimeters.sum + perimeters.min

  smallest_dimensions = dimensions.sort.take(2)
  ribbon_wrap = 2 * smallest_dimensions.sum
  ribbon_bow = l * w * h
  ribbon += ribbon_bow + ribbon_wrap
end

print "Total Paper Needed: #{paper}\n"
print "Total Ribbon Needed: #{ribbon}\n"
