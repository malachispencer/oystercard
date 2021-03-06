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

    it 'calls card_touch_in method on the Journey passed in' do
      subject.top_up(1)
      allow(journey).to receive(:card_touch_in) { 'touched in' }
      expect(subject.touch_in(journey)).to eq('touched in')
    end
  end

  describe '#touch_out' do
    let(:journey) { double :journey }

    it 'calls card_touch_out method on the Journey passed in' do
      subject.top_up(1)
      allow(journey).to receive(:card_touch_out) { 'touched out' }
      expect(subject.touch_out(journey)).to eq('touched out')
    end
  end

  describe '#deduct_fare' do
    it 'raises an error unless invoked from Journey finalize method' do
      subject.top_up(6)
      expect { subject.deduct_fare(1) }.to raise_error('Card can only be charged for Journey')
    end

    it 'reduces balance by amount/fare passed into it' do
      subject.top_up(6)
      allow(subject).to receive(:journey_action?) { true }
      expect { subject.deduct_fare(6) }.to change { subject.balance }.by(-6)
    end
  end

  describe '#log' do
    let(:journey) { double :journey }

    it 'raises an error unless invoked from Journey class' do
      expect { subject.log(journey) }.to raise_error('Cannot manually add Journey')
    end

    it 'adds a Journey to the JourneyLog' do
      allow(subject).to receive(:journey_action?) { true }
      subject.log(journey)
      expect(subject.history.first).to eq(journey)
    end
  end

  describe '#history' do
    let(:journey) { double :journey }

    it 'returns the JourneyLog array' do
      allow(subject).to receive(:journey_action?) { true }
      3.times { subject.log(journey) }

      subject.history.each do |j|
        expect(j).to eq(journey)
      end
    end
  end
end