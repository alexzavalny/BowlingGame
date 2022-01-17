require './lib/bowling_frame'

RSpec.describe BowlingFrame do
  describe "#strike?" do
    context "with 1 roll of 10" do
      subject { described_class.new }

      it "should be strike" do
        subject.add_roll 10
        expect(subject).to be_strike
      end
    end
  end
end