# 19 - Scanning
# A given robot should be able to scan its surroundings 
# (tiles immediately next to its current @position) 
# Note: You should leverage the class method implemented in #18

require_relative 'spec_helper'

# #enemy_nearby?
describe Robot do

  describe '#nearby_enemies' do
    it 'returns nearby enemies' do
      expect(subject.nearby_enemies).to be_empty
    end
  end

end