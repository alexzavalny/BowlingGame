require_relative 'bowling_frame'

class BowlingGame
  FRAME_MAX_PINS = 10
  FRAME_COUNT = 10

  def initialize
    @frames = []
    @cur_ndx = 0
    FRAME_COUNT.times { |x| @frames << BowlingFrame.new(x + 1) }
  end

  # takes an array of bowling game rolls (for 1 person)
  # and add those rolls to the gaming session
  def add_rolls(rolls)
    rolls.each { |r| add_roll r }
  end

  # returns an array of frame scores, each summed
  # as shown in real bowling game visual score
  #    i.e if each frame earned 1 point, returns (1, 2, 3, 4...)
  def summed_frames
    sum = 0
    @frames.map { |f| sum += f.score }
  end

  private
  
  # adds roll to current frame and switches the index to next frame
  def add_roll(roll)
    @frames[@cur_ndx].add_roll roll
    @cur_ndx += 1 if @frames[@cur_ndx].full?
  end
end