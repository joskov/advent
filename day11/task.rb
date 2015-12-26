input = 'hepxcrrq'

def self.check_for_consequent(input)
  (0..(input.length - 3)).each do |i|
    sliced = input.slice(i, 3)
    next if sliced[1] != sliced[0].next
    next if sliced[2] != sliced[1].next
    return true
  end
  false
end

def self.next_password(input)
  loop do
    input.next!
    next unless check_for_consequent(input)
    next if /[iol]/ =~ input
    next unless /(.)\1.*(.)\2/ =~ input
    break
  end
  input
end

input = next_password(input)
print "#{input}\n"

input = next_password(input)
print "#{input}\n"
