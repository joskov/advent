require 'active_support/all'

lines = File.readlines('input.txt')
all = 0
strings = 0
lines.each do |line|
  newline = line.dup
  newline.strip!
  next if newline.empty?
  all += newline.length
  newline.gsub!(/(["\\])/, '\\\\\1')
  # newline.gsub!(/(\\x..)|(\\")|(\\\\)/, { '$1' => '_', '$2' => '"', '$3' => '\\' })
  newline = "\"#{newline}\""
  strings += newline.length
  print "#{line} -> #{newline}\n"
end

print "Sizes: #{strings - all} ( #{strings} - #{all} )\n"
