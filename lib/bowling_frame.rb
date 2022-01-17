class BowlingFrame
  def initialize(frame_number)
    @frame_number = frame_number
    @rolls = []
  end

  # inserts roll into frame if possible
  def add_roll(roll)
    # TODO: add validation
    @rolls << roll
  end

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
    @rolls.length > 1 && @rolls[0..1].sum == 10
  end

  # calculates total score for this frame
  # NOTE: this score is isolated from other frames
  def score 
    @rolls.sum
  end
end