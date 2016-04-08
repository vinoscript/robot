class Robot

  class RobotAlreadyDeadError < StandardError ; end
  class UnattackableEnemyError < StandardError ; end

  MAX_WEIGHT = 250
  FULL_HEALTH = 100
  BASIC_DAMAGE = 5
  FULL_SHIELD = 50

  attr_reader :position, :items, :health, :shield_points

  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = FULL_HEALTH
    @equipped_weapon = nil 
    @shield_points = FULL_SHIELD
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    if item.is_a?(Weapon)
      self.equipped_weapon = item
    elsif item.is_a?(BoxOfBolts)  
      health > 80 ? items << item : item.feed(self)
    else
      unless items_weight + item.weight > MAX_WEIGHT
        items << item
      end
    end
  end

  def items_weight
    # items.reduce(0) { |sum, items| sum += items.weight }
    # items.inject(0) { |sum, items| sum + items.weight  }
    weight = 0
    items.each { |item| weight += item.weight }
    weight
  end

  def wound(amount)
    damage_to_shield = [shield_points, amount].min 
    @shield_points -= damage_to_shield
    damage_to_health = amount - damage_to_shield
    @health -= damage_to_health
    @health = 0 if health < 0

    # @health = [0, @health - damage_to_health].max
  end

  def heal(amount)
    @health += amount
    @health = FULL_HEALTH if health > FULL_HEALTH
  end

  def attack(enemy)
    x = position[0]
    y = position[1]
    one_away_positions = [[x, y+1], [x+1, y], [x, y-1], [x-1, y], [x, y]]
    two_away_positions = [[x, y+2], [x+2, y], [x, y-2], [x-2, y]]
    one_or_two_away = one_away_positions + two_away_positions

    # i = range
    # position = [x,y]
    # position.map {  }
    # all_pos = []
    # (1..range) do |i|
    #   all_pos << [x, y+ i]
    #   all_pos << [x + i, y]

    if equipped_weapon.is_a?(Grenade) && one_or_two_away.include?(enemy.position)
      equipped_weapon.hit(enemy)
      self.equipped_weapon = nil
    elsif one_away_positions.include?(enemy.position)  
      equipped_weapon ? equipped_weapon.hit(enemy) : enemy.wound(BASIC_DAMAGE)
    end

  end

  def heal!(amount)
    raise RobotAlreadyDeadError, "Can't attack a dead robot" if health <= 0 
    heal(amount)
  end

  def attack!(enemy)
    raise UnattackableEnemyError, "Can only attack other robots" unless enemy.is_a? Robot
    attack(enemy)
  end

end
