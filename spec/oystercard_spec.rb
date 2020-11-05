require 'oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'sets a default balance of 0 to our card' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it "can be called on an Oystercard instance" do
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

  describe '#touch_in' do
    let(:journey) { double :journey }
    it 'raises an exception if balance is below minimum fare' do
      expect { subject.touch_in(journey) }.to raise_error('Insufficient funds')
    end
  end

  describe '#touch_out' do
    it 'can be called on a card with 1 argument' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end
  end

  describe '#deduct_fare' do
    it 'reduces balance by amount/fare passed into it' do
      subject.top_up(6)
      expect { subject.deduct_fare(6) }.to change { subject.balance }.by(-6)
    end
  end
end