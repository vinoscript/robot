# 15 - Introduce Shields
# Robots can start with 50 shield points. When the robot is damaged 
# it first drains the shield and then starts affecting actual health.

# You will likely also have to fix previous tests that will fail 
# due to this enhancement. However, focus on running spec 16 until 
# you are done, then rerun all your tests to find other failing 
# tests and modify the tests to modify their expectations.

require_relative 'spec_helper'

describe Robot do
  
  before :each do
    @robot = Robot.new
  end

  describe "#shield_points" do
    
    it "should start with 50 shield points" do
      expect(@robot.shield_points).to eq(50)
    end

  end

  describe "#wound" do

    it "should not reduce health until shield points have run out" do
      expect(@robot.shield_points).to eq(50)
      @robot.wound(20)
      expect(@robot.health).to eq(100)
    end

    it "should reduce health once shield points have run out" do
      expect(@robot).to receive(:shield_points).and_return(0)
      @robot.wound(20)
      expect(@robot.health).to eq(80)
    end

    it "should reduce health once shield points have run out" do
      expect(@robot).to receive(:shield_points).and_return(5)
      @robot.wound(20)
      expect(@robot.health).to eq(85)
    end

  end


end