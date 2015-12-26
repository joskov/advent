str = File.read('input.txt')

floor = 0
pos = 0
str.each_char do |char|
  pos += 1
  case char
  when '('
    floor += 1
  when ')'
    floor -= 1
  end
  print "level #{floor} on position #{pos}\n"
end
