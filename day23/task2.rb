require 'active_support/all'

lines = File.readlines('input.txt')
lines.map! do |i|
  matches = i.strip.match(/(\w+)\s(.*)/)
  [matches[1], matches[2].split(', ')]
end

@data = { 'a' => 1, 'b' => 0 }
@lines = lines
def self.execute(line_num)
  line = @lines[line_num]
  return nil unless line.present?
  case line[0]
  when 'hlf'
    @data[line[1][0]] /= 2
  when 'tpl'
    @data[line[1][0]] *= 3
  when 'inc'
    @data[line[1][0]] += 1
  when 'jmp'
    return line_num + line[1][0].to_i
  when 'jie'
    return line_num + line[1][1].to_i if @data[line[1][0]].even?
  when 'jio'
    return line_num + line[1][1].to_i if @data[line[1][0]] == 1
  end
  line_num + 1
end

line_num = 0
loop do
  break unless line_num.present?
  line_num = execute(line_num)
end

print @data
print "\n"
