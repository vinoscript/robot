class Battery < Item

  def initialize
    super('Battery', 25)
  end

  def recharge_shield(robot)
    p robot.shield_points = 50
  end

end
