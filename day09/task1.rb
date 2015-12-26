require 'active_support/all'

# Connection
class Connection
  attr_reader :from, :to, :distance

  def initialize(from, to, distance)
    @from = from
    @to = to
    @distance = distance
  end

  def from_town
    Town.find(from)
  end

  def to_town
    Town.find(to)
  end
end

# Town
class Town
  attr_reader :name, :connections
  @@all = []

  def initialize(name)
    @name = name
    @connections = []
  end

  def connection_with(town)
    connections.each do |connection|
      return connection if connection.to == town.name
    end
    nil
  end

  def self.find(name)
    all.each do |town|
      return town if town.name == name
    end
    nil
  end

  def self.init(name)
    if (old = find(name)).nil?
      old = Town.new(name)
      all << old
    end
    old
  end

  def self.all
    @@all
  end

  def self.trip_distance(towns_left, from_town = nil)
    return 0 if towns_left.empty?
    distances = []
    towns_left.each do |to_town|
      new_towns_left = towns_left.dup
      new_towns_left.delete(to_town)
      if from_town.nil?
        distance = 0
      else
        distance = from_town.connection_with(to_town).distance
      end
      distances << distance + trip_distance(new_towns_left, to_town)
    end
    distances.min
  end
end

lines = File.readlines('input.txt')
lines.each do |line|
  matches = line.match(/(\w+)\sto\s(\w+)\s=\s(\d+)/)
  town_1 = Town.init(matches[1])
  town_2 = Town.init(matches[2])
  distance = matches[3].to_i
  town_1.connections << Connection.new(matches[1], matches[2], distance)
  town_2.connections << Connection.new(matches[2], matches[1], distance)
end

print "Distance: #{Town.trip_distance(Town.all)}\n"
