# 1. Implement Robot#heal!
# Create a new instance method in the Robot class called heal!. 
# This method will be slightly different than the previously defined 
# heal (without a bang) method, in that this one is more aggressive in how it behaves.

# Robot#heal! should raise an exception if the robot is already at 0 health or less. 
# In other words, once a robot is dead, it cannot be revived.

require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
  end
  
  describe "#heal!" do
    it "raises an error if robot health is <= 0" do
      expect(@robot).to receive(:health).and_return(0)
      expect { @robot.heal!(20) }.to raise_error(Robot::RobotAlreadyDeadError)
    end
  end


end

