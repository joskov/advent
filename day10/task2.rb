input = '1113122113'

def self.apply(input)
  list = []
  input.each do |int|
    last = list.last
    if last.nil? || last[:int] != int
      list << { count: 1, int: int.to_i }
    else
      last[:count] += 1
    end
  end
  list.map(&:values).flatten
end

output = input.split(//).map(&:to_i)
50.times do |i|
  print "Iteration #{i}\n"
  output = apply(output)
end
print "#{output.length}\n"
