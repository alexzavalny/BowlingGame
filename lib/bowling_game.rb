require_relative 'bowling_frame'

class BowlingGame
  def initialize
  end

  # takes an array of bowling game rolls (for 1 person)
  # and add those rolls to the gaming session
  def add_rolls(rolls)
  end

  # returns an array of frame scores, each summed
  # as shown in real bowling game visual score
  #    i.e if each frame earned 1 point, returns (1, 2, 3, 4...)
  def summed_frames
    []
  end
end