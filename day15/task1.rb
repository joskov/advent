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

# Ingredient
class Ingredient < Hash
  attr_accessor :name

  ATTRIBUTES = %w(capacity durability flavor texture)

  def self.from_string(string)
    matches = /(\w+):\s(.*)/.match(string)
    print "#{matches[2]}\n"
    record = new
    record.name = matches[1]
    matches[2].split(', ').each do |item|
      key, value = item.split(' ')
      record[key] = value.to_i
    end
    record
  end

  def self.sum(ingredients, multipliers)
    result = new
    result.name = 'Sum'
    ATTRIBUTES.each do |key|
      result[key] = 0
    end
    ingredients.each_with_index do |ingredient, index|
      ATTRIBUTES.each do |key|
        result[key] += ingredient[key] * multipliers[index]
      end
    end
    result
  end

  def score
    result = 1
    %w(capacity durability flavor texture).each do |score|
      value = self[score]
      return 0 if value <= 0
      result *= self[score]
    end
    result
  end
end

ingredients = []
lines.each do |line|
  ingredients << Ingredient.from_string(line)
end

max_score = 0
(0..100).each do |i1|
  (0..(100 - i1)).each do |i2|
    (0..(100 - i1 - i2)).each do |i3|
      i4 = 100 - i1 - i2 - i3
      multipliers = [i1, i2, i3, i4]
      result = Ingredient.sum(ingredients, multipliers).score
      max_score = result if result > max_score
    end
  end
end

print "#{max_score}\n"
