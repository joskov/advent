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

def self.play(deers, time)
  time.times do |_current_time|
    deers.each do |deer|
      current_gear = deer[:gears][deer[:gear]]
      gear_speed, gear_time = current_gear
      deer[:distance] += gear_speed
      deer[:gear_time] += 1

      if deer[:gear_time] == gear_time
        deer[:gear] = deer[:gear] == 0 ? 1 : 0
        deer[:gear_time] = 0
      end
    end
    max_distance = deers.map { |deer| deer[:distance] }.max
    deers.each do |deer|
      deer[:points] += 1 if deer[:distance] == max_distance
    end
  end
end

deers = []
lines.each do |line|
  matches = %r{(\w+)\scan\sfly\s(\d+)\skm\/s\sfor\s(\d+)\sseconds\,\sbut\sthen\smust\srest\sfor\s(\d+)\sseconds.}.match(line)
  deer = matches[1]
  speed = matches[2].to_i
  time = matches[3].to_i
  rest = matches[4].to_i
  deer = { deer: deer, gears: [[speed, time], [0, rest]], gear: 0, gear_time: 0, distance: 0, points: 0 }
  deers << deer
end

play(deers, 2503)

deers.each do |deer|
  print "#{deer[:points]}\n"
end
print "#{deers}\n"

points = deers.map { |deer| deer[:points] }
print "#{points.max}\n"
