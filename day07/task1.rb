require 'active_support/all'

# Utils
class Utils
  def self.value_of(values, sym)
    return sym.to_i if /^\d+$/ =~ sym
    value = values[sym]
    print "Finding value of [#{sym}] which is: #{value}\n"
    if value.is_a?(Fixnum)
      result = value
    elsif value.is_a?(String)
      if /^\d+$/ =~ value
        result = value.to_i
      elsif /^[a-z]+$/ =~ value
        result = value_of(values, value)
      else
        fail
      end
    elsif value.is_a?(Hash)
      result = calculate(values, value)
    else
      fail
    end
    values[sym] = result
    result
  end

  def self.calculate(values, hash)
    if hash.keys == [:o, :r]
      fail if hash[:o] != 'NOT'
      return (2**16 + ~value_of(values, hash[:r]))
    elsif hash.keys == [:l, :o, :r]
      left = value_of(values, hash[:l])
      right = value_of(values, hash[:r])
      case hash[:o]
      when 'AND'
        return left & right
      when 'OR'
        return left | right
      when 'LSHIFT'
        return left << right
      when 'RSHIFT'
        return left >> right
      else
        fail
      end
    else
      fail
    end
  end
end

lines = File.readlines('input.txt')
values = {}
lines.each do |line|
  left, right = line.split(' -> ')
  sym = right.strip
  if (matches = left.match(/^\d+$/))
    values[sym] = left.to_i
  elsif (matches = left.match(/^([a-z\d]+)\s([A-Z]+)\s([a-z\d]+)$/))
    values[sym] = { l: matches[1], o: matches[2], r: matches[3] }
  elsif (matches = left.match(/^([A-Z]+)\s([a-z]+)$/))
    values[sym] = { o: matches[1], r: matches[2] }
  elsif (matches = left.match(/^([a-z]+)$/))
    values[sym] = matches[1]
  else
    print left
    fail
  end
end

value = Utils.value_of(values, 'a')
print "Value of a eq: #{value}\n"
