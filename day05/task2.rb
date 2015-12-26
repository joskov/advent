require 'active_support/all'

lines = File.readlines('input.txt')

nice = 0
all = 1
lines.each do |line|
  all += 1
  print line
  next unless /(..).*\1/ =~ line # same two letters twice
  next unless /(.).\1/ =~ line # one letter between same letters
  # next unless /(?=.*(..).*\1)(?=.*(.).\2).*/ =~ line
  nice += 1
end

print "Total Nice Strings: #{nice}/#{all}\n"
