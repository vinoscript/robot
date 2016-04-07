# 2. Implement Robot#attack!
# Robot#attack! should raise an exception if the target being attacked is not a robot. 
# A user should not be able to attack an Item or anything other than a Robot.


require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
    @enemy = Item.new('book', 15)
  end
  
  describe "#attack!" do
    it "raises an error if enemy is not a robot" do
      expect { @robot.attack!(@enemy) }.to raise_error(Robot::UnattackableEnemyError)
    end
  end


end