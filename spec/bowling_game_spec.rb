require './lib/bowling_game'

RSpec.describe BowlingGame do
  describe "#add_rolls" do
    context "if 13 strikes is added" do
      subject { described_class.new }

      it "should raise error" do
        expect{ subject.add_rolls([10] * 13)  }.to raise_error(BowlingGameError)
      end
    end
  end

  describe "#summed_frames" do
    context "with zero hits" do
      subject { described_class.new }

      it "returns zero for each frame" do
        subject.add_rolls [0] * 20
        expect(subject.summed_frames).to eq [0] * 10
      end
    end

    context "with no strikes or spares" do
      subject { described_class.new }

      it "sums the pins for each roll" do
        subject.add_rolls [1] * 20
        expect(subject.summed_frames).to eq [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
      end
    end

    context "with all spares" do
      subject { described_class.new }

      it "sums the pins for each roll" do
        subject.add_rolls [5] * 21
        expect(subject.summed_frames).to eq [15, 30, 45, 60, 75, 90, 105, 120, 135, 150]
      end
    end

    context "with all strikes" do
      subject { described_class.new }

      it "sums the pins for each roll" do
        subject.add_rolls [10] * 12
        expect(subject.summed_frames).to eq [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      end
    end

    context "with strike-spare-strike-spare alteration" do
      subject { described_class.new }

      it "sums the pins for each roll" do
        subject.add_rolls [10, 5, 5] * 5 + [5]
        expect(subject.summed_frames).to eq [20, 40, 60, 80, 100, 120, 140, 160, 180, 195]
      end
    end
  end
end