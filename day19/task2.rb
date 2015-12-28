require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test2.txt')

def self.add_transformation(line)
  matches = line.match(/(\w+)\s=>\s(\w+)/)
  key = matches[1]
  molecule = matches[2].strip
  @transformations[key] ||= []
  @transformations[key] << split_molecule(molecule)
end

def self.split_molecule(molecule)
  molecule.strip.split(/(?=[A-Z])/)
end

@transformations = {}
@molecule = split_molecule(lines.pop)
lines.pop

lines.each do |line|
  add_transformation(line)
end

def self.hack(molecule)
  result = molecule.count - 1
  molecule.each do |atom|
    case atom
    when 'Rn', 'Ar'
      result -= 1
    when 'Y'
      result -= 2
    end
  end
  result
end

print "#{@molecule}\n"
print "#{@transformations}\n"

print "Result is: #{hack(@molecule)}\n"
