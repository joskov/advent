require 'active_support/all'

MINE_HP = 100

boss = {
  hp: 100,
  damage: 8,
  armor: 2
}

@weapons = [
  { cost: 8, damage: 4, armor: 0 },
  { cost: 10, damage: 5, armor: 0 },
  { cost: 25, damage: 6, armor: 0 },
  { cost: 40, damage: 7, armor: 0 },
  { cost: 74, damage: 8, armor: 0 }
]

@armor = [
  { cost: 13, damage: 0, armor: 1 },
  { cost: 31, damage: 0, armor: 2 },
  { cost: 53, damage: 0, armor: 3 },
  { cost: 75, damage: 0, armor: 4 },
  { cost: 102, damage: 0, armor: 5 }
]

@rings = [
  { cost: 25, damage: 1, armor: 0 },
  { cost: 50, damage: 2, armor: 0 },
  { cost: 100, damage: 3, armor: 0 },
  { cost: 20, damage: 0, armor: 1 },
  { cost: 40, damage: 0, armor: 2 },
  { cost: 80, damage: 0, armor: 3 }
]

def self.stats(weapon, armor_type, ring1, ring2)
  damage = 0
  armor = 0
  price = 0

  damage += weapon[:damage]
  price += weapon[:cost]

  if armor_type.present?
    armor += armor_type[:armor]
    price += armor_type[:cost]
  end

  [ring1, ring2].each do |ring|
    next unless ring.present?
    damage += ring[:damage]
    armor += ring[:armor]
    price += ring[:cost]
  end

  { damage: damage, armor: armor, price: price, hp: MINE_HP }
end

def self.play_battle(player, boss)
  player_hp = player[:hp]
  boss_hp = boss[:hp]
  loop do
    boss_hp -= [1, player[:damage] - boss[:armor]].max
    return true if boss_hp <= 0
    player_hp -= [1, boss[:damage] - player[:armor]].max
    return false if player_hp <= 0
  end
end

stats_list = []
# TODO: fix repeating ring combos
@weapons.each do |weapon|
  (@armor + [nil]).each do |armor|
    (@rings + [nil]).each do |ring1|
      (@rings - [ring1] + [nil]).each do |ring2|
        stats_list << stats(weapon, armor, ring1, ring2)
      end
    end
  end
end

stats_list.sort_by! { |obj| obj[:price] }

stats_list.each do |stats|
  result = play_battle(stats, boss)
  next unless result
  print stats
  break
end

print "\n"
