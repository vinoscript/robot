# 16 - Implement Batteries
# Batteries are items that can be used by robot to recharge its shield. 
# Implement Battery item that can be used to recharge the Robot’s shield. 
# Batteries have a weight of 25.

require_relative 'spec_helper'

describe Battery do 

  before :each do
    @battery = Battery.new
  end

  it "should be an item" do 
    expect(@battery).to be_a Item
  end

  it "has name 'Battery'" do
    expect(@battery.name).to eq("Battery")
  end

  it "has 25 weight" do
    expect(@battery.weight).to eq(25)
  end

  describe "#recharge_shield" do

    before :each do
      @robot = Robot.new
    end

    it "recharges the robot's shield" do
      @battery.recharge_shield(@robot)
      expect(@robot.shield_points).to eq(50)
    end

  end
  
end