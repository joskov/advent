require 'active_support/all'

lines = File.readlines('input.txt')
# lines = File.readlines('test.txt')

def self.add_transformation(line)
  matches = line.match(/(\w+)\s=>\s(\w+)/)
  key = matches[1]
  molecule = split_molecule(matches[2])
  @transformations[key] ||= []
  @transformations[key] << molecule
end

def self.split_molecule(molecule)
  molecule.strip.split(/(?=[A-Z])/)
end

def self.possible_molecules(old_molecules)
  new_molecules = []
  old_molecules.each do |molecule|
    molecule.each_with_index do |value, index|
      possible_transformations = @transformations[value]
      next if possible_transformations.nil?
      possible_transformations.each do |transformation|
        new_molecule = molecule.dup
        new_molecule[index] = transformation
        new_molecule.flatten!
        new_molecules << new_molecule
      end
    end
  end
  new_molecules.uniq!
  new_molecules
end

@transformations = {}
@molecule = split_molecule(lines.pop)
lines.pop

lines.each do |line|
  add_transformation(line)
end

result = possible_molecules([@molecule])

print result.count
print "\n"
