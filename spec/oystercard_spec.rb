require 'oystercard'

describe Oystercard do
  context '#initialize' do
    it 'sets a default balance of 0 to our card' do
      expect(subject.balance).to eq(0)
    end
  end

  context '#top_up' do
    it "can be called on an Oystcard instance" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'adds money to our Oystercard balance' do
      expect { subject.top_up(5) }.to change { subject.balance }.from(0).to(5)
    end

    it 'raises an exception when balance exceeds the maximum limit' do
      subject.top_up(89)
      expect { subject.top_up(2) }.to raise_error('Balance cannot be above 90')
    end
  end

  context '#in_journey?' do
    it 'returns a boolean value' do
      expect(subject.in_journey?).to eq(false).or eq(true)
    end
  end

  context '#touch_in' do
    it 'changes in_journey instance variable from false to true' do
      subject.top_up(5)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it 'raises an exception if balance is below 1' do
      expect { subject.touch_in }.to raise_error('Insufficient funds')
    end
  end

  context '#touch_out' do
    it 'changes in_journey instance variable from true to false' do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it 'charges the Oystercard by minimum fare' do
      subject.top_up(20)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  context '#deduct' do
    it 'deducts a fare from an Oystercard instance' do
      subject.top_up(20)
      expect(subject.send(:deduct)).to eq(19)
    end
  end
end