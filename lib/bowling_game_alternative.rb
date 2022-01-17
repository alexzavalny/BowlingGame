# This is not main code. This is alternative version, not OOP style. Just for discussing. 
# no validations added, purely algorithmical work.
# this class has same "interface" and can be tested with same tests (except validation tests) 
class BowlingGameAlternative
    FRAME_MAX_PINS = 10
    FRAME_COUNT = 10
  
    def initialize()
    end 

    def add_rolls(rolls)
      @frames = [0] * FRAME_COUNT
      ndx = frame_ndx = frame_sum = 0
  
      while frame_ndx < FRAME_COUNT && ndx < rolls.length
        if rolls[ndx] == FRAME_MAX_PINS # is strike
          frame_sum = rolls[ndx..ndx + 2].sum
          ndx += 1
        else
          frame_sum = rolls[ndx..ndx + 1].sum
          frame_sum += rolls[ndx + 2] if frame_sum == FRAME_MAX_PINS # is spare
          ndx += 2
        end
  
        previous_frame_sum = @frames[frame_ndx - 1] || 0
        @frames[frame_ndx] = frame_sum + previous_frame_sum
        frame_ndx += 1
      end
    end

    def summed_frames
        @frames
    end
  end