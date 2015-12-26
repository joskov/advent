require 'active_support/all'

lines = File.readlines('input.txt')

nice = 0
all = 1
lines.each do |line|
  all += 1
  print line
  next unless line.scan(/[aeiou]/).size >= 3 # contains letter
  next unless /(.{1})\1/ =~ line # same letter twice
  next if /ab|cd|pq|xy/ =~ line # ab, cd, pq, or xy
  nice += 1
end

print "Total Nice Strings: #{nice}/#{all}\n"
