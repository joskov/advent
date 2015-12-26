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

# Aunt
class Aunt < Hash
  attr_accessor :id

  def self.from_string(string)
    matches = /Sue\s(\d+):\s(.*)/.match(string)
    # print "#{matches[2]}\n"
    record = new
    record.id = matches[1].to_i
    matches[2].split(', ').each do |item|
      key, value = item.split(': ')
      record[key] = value.to_i
    end
    record
  end

  def matches(other)
    other.keys.each do |key|
      next unless self.key?(key)
      next if check_value(other, key)
      return false
    end
    true
  end

  def check_value(other, key)
    case key
    when 'cats', 'trees'
      operator = '>'
    when 'pomeranians', 'goldfish'
      operator = '<'
    else
      operator = '=='
    end
    self[key].send(operator, other[key])
  end
end

aunts = []

check = Aunt.new
check['children'] = 3
check['cats'] = 7
check['samoyeds'] = 2
check['pomeranians'] = 3
check['akitas'] = 0
check['vizslas'] = 0
check['goldfish'] = 5
check['trees'] = 3
check['cars'] = 2
check['perfumes'] = 1

lines.each do |line|
  aunt = Aunt.from_string(line)
  aunts << aunt
  print "#{aunt.id}\n" if aunt.matches(check)
end

# print "#{check}\n"
