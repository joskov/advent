require 'active_support/all'

file = File.read('input.txt')
result = JSON.parse(file)

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

print "#{sum_numbers(result)}\n"
