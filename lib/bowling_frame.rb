class BowlingFrame
  def initialize(frame_number)
    @frame_number = frame_number
    @rolls = []
  end

  # inserts roll into frame is possible
  def add_roll(roll)
  end

  # checks if first roll is 10
  def strike?
  end
  
  # checks if two rolls sum is 10
  def spare?
  end

  # calculates total score for this frame
  # NOTE: this score is isolated from other frames
  def score 
  end
end