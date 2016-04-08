class Robot

  class RobotAlreadyDeadError < StandardError ; end
  class UnattackableEnemyError < StandardError ; end

  MAX_WEIGHT = 250
  FULL_HEALTH = 100
  BASIC_DAMAGE = 5

  attr_reader :position, :items, :health

  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = FULL_HEALTH
    @equipped_weapon = nil 
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
    unless items_weight + item.weight > MAX_WEIGHT
      self.equipped_weapon = item if item.is_a? Weapon
      items << item
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
    @health -= amount
    @health = 0 if health < 0
  end

  def heal(amount)
    @health += amount
    @health = FULL_HEALTH if health > FULL_HEALTH
  end

  def attack(enemy)
    x = position[0]
    y = position[1]
    if [[x, y+1], [x+1, y], [x, y-1], [x-1, y]].include?(enemy.position)
      equipped_weapon == nil ? enemy.wound(BASIC_DAMAGE) : equipped_weapon.hit(enemy)
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
