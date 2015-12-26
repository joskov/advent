require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test2.txt')

def self.add_transformation(line)
  matches = line.match(/(\w+)\s=>\s(\w+)/)
  key = matches[1]
  molecule = matches[2].strip
  @transformations[key] ||= []
  @transformations[key] << molecule
end

def self.possible_origins(molecules)
  result = []
  molecules.each do |molecule|
    find_origins(molecule, result)
  end
  result.uniq!
  result.sort!
  result
end

def self.find_origins(molecule, result)
  @transformations.each do |key, transformation|
    transformation.each do |possible_transformation|
      transformation_length = possible_transformation.length
      (0..(molecule.length - transformation_length + 1)).each do |index|
        next unless molecule.slice(index, transformation_length) == possible_transformation
        origin_molecule = molecule.dup
        origin_molecule.slice!(index, transformation_length)
        origin_molecule.insert(index, key)
        result << origin_molecule
      end
    end
  end
  nil
end

@transformations = {}
@molecule = lines.pop.strip
lines.pop

lines.each do |line|
  add_transformation(line)
end

result = [@molecule]
iterations = 0
loop do
  result = possible_origins(result)
  iterations += 1
  print "Iteration: #{iterations}, possible origins: #{result.count}\n"
  break if result.include?('e')
end
result = 0

print "Result is: #{iterations}\n"
