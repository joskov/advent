require 'active_support/all'

lines = File.readlines('input.txt')

def self.distance(deer, time)
  result = 0
  left = time
  loop do
    deer[:gears].each do |speed, gear_time|
      delta = [gear_time, left].min
      left -= delta
      result += delta * speed
      return result if left == 0
    end
  end
end

deers = []
max = 0
lines.each do |line|
  matches = %r{(\w+)\scan\sfly\s(\d+)\skm\/s\sfor\s(\d+)\sseconds\,\sbut\sthen\smust\srest\sfor\s(\d+)\sseconds.}.match(line)
  deer = matches[1]
  speed = matches[2].to_i
  time = matches[3].to_i
  rest = matches[4].to_i
  deer = { deer: deer, gears: [[speed, time], [0, rest]] }
  deer_distance = distance(deer, 2503)
  print "#{deer_distance}\n"
  max = deer_distance if deer_distance > max
  deers << deer
end

print "#{deers}\n"
print "#{max}\n"

# print "#{results.max}\n"
