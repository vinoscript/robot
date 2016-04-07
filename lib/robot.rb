class Robot

  attr_reader :position, :items, :health

  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
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
    unless items_weight + item.weight > 250
      self.equipped_weapon = item if item.is_a? Weapon
      @items << item
    end
  end

  def items_weight
    # @items.reduce(0) { |sum, items| sum += items.weight }
    weight = 0
    @items.each do |item|
      weight += item.weight 
    end
    weight
  end

  def wound(amount)
    @health -= amount
    @health = 0 if @health < 0
  end

  def heal(amount)
    @health += amount
    @health = 100 if @health > 100
  end

  def attack(enemy)
    # make into ternary
    if equipped_weapon == nil
      enemy.wound(5)
    else
      equipped_weapon.hit(enemy)
    end
  end


end
