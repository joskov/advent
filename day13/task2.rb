require 'active_support/all'

lines = File.readlines('input.txt')

def self.sum_numbers(object)
  result = 0
  if object.is_a?(Hash)
    object.each do |_k, v|
      return 0 if v == 'red'
      result += sum_numbers(v)
    end
  elsif object.is_a?(Array)
    object.each do |v|
      result += sum_numbers(v)
    end
  elsif object.is_a?(Fixnum)
    result = object
  end
  result
end

changes = {}
people = []
lines.each do |line|
  matches = /(\w+)\swould\s(lose|gain)\s(\d+)\shappiness units by sitting next to\s(\w+)./.match(line)
  person_left = matches[1]
  person_right = matches[4]
  change = (matches[2] == 'gain') ? +matches[3].to_i : -matches[3].to_i
  changes[[person_left, person_right]] = change
  people << person_left
  people << person_right
end

def self.find_change(changes, person1, person2)
  changes[[person1, person2]] || 0
end

people.uniq!
people << 'me'

results = []
people.permutation.to_a.each do |permutation|
  result = 0
  (0..(permutation.length - 2)).each do |i|
    result += find_change(changes, permutation[i], permutation[i + 1])
    result += find_change(changes, permutation[i + 1], permutation[i])
  end
  result += find_change(changes, permutation.last, permutation.first)
  result += find_change(changes, permutation.first, permutation.last)
  results << result
end

print "#{changes}\n\n"

print "#{results.max}\n"
