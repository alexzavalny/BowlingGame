require './lib/bowling_frame'

RSpec.describe BowlingFrame do
  describe "#full?" do
    context "in first frame" do
      subject { described_class.new(1) }

      context "with no rolls" do
        it "should not be full" do
          expect(subject).to_not be_full
        end
      end

      context "with 1 roll, not strike" do
        it "should be full" do
          subject.add_roll(1)
          expect(subject).to_not be_full
        end
      end

      context "with 1 roll, strike" do
        it "should be full" do
          subject.add_roll(10)
          expect(subject).to be_full
        end
      end

      context "with 2 rolls" do
        subject { described_class.new(1) }

        it "should return true" do
          2.times { subject.add_roll(1) }
          expect(subject).to be_full
        end
      end
    end

    context "in last frame" do
      subject { described_class.new(10) }

      context "with no rolls" do
        it "should not be full" do
          expect(subject).to_not be_full
        end
      end

      context "with 1 roll of not strike (1 pin)" do
        it "should not be full" do
          subject.add_roll(1)
          expect(subject).to_not be_full
        end
      end

      context "with 1 roll of strike (10 pins)" do
        it "should not be full" do
          subject.add_roll(1)
          expect(subject).to_not be_full
        end
      end

      context "with 2 rolls of not spare" do
        it "should be full" do
          subject.add_roll(1)
          subject.add_roll(6)
          expect(subject).to be_full
        end
      end

      context "with 2 rolls of spare" do
        it "should not be full" do
          subject.add_roll(1)
          subject.add_roll(9)
          expect(subject).to_not be_full
        end
      end

      context "with 3 rolls (one strike, then 1, 1 pin)" do
        it "should be full" do
          subject.add_roll(10)
          subject.add_roll(1)
          subject.add_roll(1)
          expect(subject).to be_full
        end
      end

      context "with 3 rolls (one strike, then strike, then 1 pin)" do
        it "should be full" do
          subject.add_roll(10)
          subject.add_roll(10)
          subject.add_roll(1)
          expect(subject).to be_full
        end
      end

      context "with 3 rolls (three strikes)" do
        it "should be full" do
          subject.add_roll(10)
          subject.add_roll(10)
          subject.add_roll(10)
          expect(subject).to be_full
        end
      end

      context "with 3 rolls (spare, then less then 10 pin)" do
        it "should be full" do
          subject.add_roll(5)
          subject.add_roll(5)
          subject.add_roll(5)
          expect(subject).to be_full
        end
      end

      context "with 3 rolls (spare, then strike)" do
        it "should be full" do
          subject.add_roll(5)
          subject.add_roll(5)
          subject.add_roll(10)
          expect(subject).to be_full
        end
      end
    end
  end

  describe "#strike?" do
    subject { described_class.new(1) }

    context "with no rolls" do
      it "should not be strike" do
        expect(subject).to_not be_strike
      end
    end

    context "with 1 roll of less then 10 pins" do      
      it "should not be strike" do
        subject.add_roll 9
        expect(subject).to_not be_strike
      end
    end

    context "with 2 rolls, total less 10 pins" do      
      it "should not be strike" do
        subject.add_roll 1
        subject.add_roll 6
        expect(subject).to_not be_strike
      end
    end

    context "with 2 rolls, total = 10 pins (spare)" do      
      it "should not be strike" do
        subject.add_roll 1
        subject.add_roll 9
        expect(subject).to_not be_strike
      end
    end

    context "with 1 roll of 10 pins" do      
      it "should be strike" do
        subject.add_roll 10
        expect(subject).to be_strike
      end
    end
  end

  describe "#spare?" do
    subject { described_class.new(1) }

    context "with no rolls" do
      it "should not be spare" do
        expect(subject).to_not be_spare
      end
    end

    context "with 1 roll of less then 10 pins" do      
      it "should not be strike" do
        subject.add_roll 9
        expect(subject).to_not be_spare
      end
    end

    context "with 2 rolls, total less 10 pins" do      
      it "should not be strike" do
        subject.add_roll 1
        subject.add_roll 6
        expect(subject).to_not be_spare
      end
    end

    context "with 2 rolls, total = 10 pins (spare)" do      
      it "should not be strike" do
        subject.add_roll 1
        subject.add_roll 9
        expect(subject).to be_spare
      end
    end

    context "with 1 roll of 10 pins" do      
      it "should be strike" do
        subject.add_roll 10
        expect(subject).to_not be_spare
      end
    end
  end

  describe "#score" do
    subject { described_class.new(1) }

    context "with no rolls" do
      it "should be zero" do
        expect(subject.score).to eq 0
      end
    end

    context "with 2 roll of 4 pins" do      
      it "should be sum of 4+4=8" do
        2.times { subject.add_roll 4 }
        expect(subject.score).to eq 8
      end
    end

    context "with 2 roll of 1 pin and 2 pins" do      
      it "should be sum of 1+2=3" do
        subject.add_roll 1
        subject.add_roll 2
        expect(subject.score).to eq 3
      end
    end
  end

  describe "#needs_reward?" do
    context "in first frame" do
      subject { described_class.new(1) }

      context "with no rolls" do
        it "should not need reward" do
          expect(subject.needs_reward?).to be false
        end
      end

      context "with 1 roll" do
        it "should not need reward" do
          subject.add_roll(1)
          expect(subject.needs_reward?).to be false
        end
      end

      context "with 2 rolls, not spare" do
        it "should not need reward" do
          subject.add_roll(1)
          subject.add_roll(1)
          expect(subject.needs_reward?).to be false
        end
      end

      context "with 1 roll, strike" do
        it "should need reward" do
          subject.add_roll(10)
          expect(subject.needs_reward?).to be true
        end
      end

      context "with 1 roll, strike, and 1 reward" do
        it "should need reward" do
          subject.add_roll(10)
          subject.add_reward(5)
          expect(subject.needs_reward?).to be true
        end
      end

      context "with 1 roll, strike, and 2 reward" do
        it "should not need reward" do
          subject.add_roll(10)
          subject.add_reward(5)
          subject.add_reward(5)
          expect(subject.needs_reward?).to be false
        end
      end

      context "with 2 rolls, spare and 1 reward" do
        it "should not need reward" do
          subject.add_roll(5)
          subject.add_reward(5)
          subject.add_reward(5)
          expect(subject.needs_reward?).to be false
        end
      end

      context "with 2 rolls, spare" do
        it "should need reward" do
          subject.add_roll(5)
          subject.add_roll(5)
          expect(subject.needs_reward?).to be true
        end
      end
    end
  end

  describe "#add_reward" do
  end
end