require_relative 'bowling_frame'
require_relative 'bowling_game_error'

class BowlingGame
  FRAME_COUNT = 10

  def initialize
    @frames = []
    @current_frame_index = 0
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
    # TODO: should raise exception if not full ten frames?

    sum = 0
    @frames.map { |f| sum += f.score }
  end

  private
  # Gives roll as a reward to all frames that are waiting for reward
  # because only 2 previous frames can be waiting for reward, we only 
  # check them.
  def giveaway_rewards(roll)
    @frames[0..@current_frame_index - 1].each do |frame|
      frame.add_reward(roll) if frame.needs_reward?
    end
  end

  # adds roll to current frame and switches the index to next frame
  def add_roll(roll)
    raise BowlingGameError, "Too many rolls" if @frames.last.full? 

    giveaway_rewards roll
    @frames[@current_frame_index].add_roll roll
    @current_frame_index += 1 if @frames[@current_frame_index].full?
  end
end