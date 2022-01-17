require_relative 'bowling_game_error'

class BowlingFrame
  FRAME_MAX_PINS = 10

  # takes frame_number as parameter for initialization, needs for logic of 10th frame
  def initialize(frame_number)
    @frame_number = frame_number
    @rolls = []
    @rewards = []
  end

  # inserts roll into frame if possible
  def add_roll(roll)
    raise BowlingGameError, "Cannot add roll to full frame" if full?
    if roll > FRAME_MAX_PINS 
      raise BowlingGameError, "Cannot add roll - pins exceed max count" 
    end

    if (@rolls.length == 1 && @rolls[0] + roll > FRAME_MAX_PINS && @frame_number < 10)
      raise BowlingGameError, "Cannot add roll - pins exceed max count" 
    end
    
    @rolls << roll 
  end

  # add reward to the frame with strike or spare
  def add_reward(reward)
    raise BowlingGameError, "Cannot add reward to this frame" unless needs_reward?
    @rewards << reward 
  end 

  # checks if frame needs more rewards
  #  frame needs 0 rewards if no strike or spare
  #  frame needs 1 reward if spare
  #  frame needs 2 rewards if strike
  #  reward is next 1/2 roll added to score
  def needs_reward?
    return false unless full?
    return true if strike? && (@rewards.length < 2)
    return true if spare? && @rewards.empty?

    false
  end

  # checks if frame is full with rolls 
  #  - 2 for 1..9 frame
  #  - 2 for 10th if no strike or spare
  #  - 3 for 10th if strike or spare
  def full?
    if @frame_number < 10
      strike? or @rolls.length == 2
    else
      @rolls.length == if strike? || spare?
                         3
                       else
                         2
                       end
    end
  end

  # checks if first roll is 10
  def strike?
    @rolls[0] == 10
  end
  
  # checks if two rolls sum is 10
  def spare?
    @rolls.length > 1 && @rolls[0..1].sum == 10 && @rolls[0] != 10
  end

  # calculates total score for this frame
  # NOTE: this score is isolated from other frames
  def score 
    @rolls.sum + @rewards.sum
  end
end