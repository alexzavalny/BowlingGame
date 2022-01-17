require './lib/bowling_game'

RSpec.describe BowlingGame do
  describe "#summed_frames" do
    context "with no strikes or spares" do
      subject { described_class.new }

      it "sums the pins for each roll" do
        subject.add_rolls [1] * 20
        expect(subject.summed_frames).to eq [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
      end
    end
  end
end