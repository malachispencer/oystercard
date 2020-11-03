require 'oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'sets a default balance of 0 to our card' do
      expect(subject.balance).to eq(0)
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up' do
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

  describe '#touch_in' do
    let(:station) { double :station }

    it 'raises an exception if balance is below 1' do
      expect { subject.touch_in(station) }.to raise_error('Insufficient funds')
    end

    it 'changes @current_journey from nil to Journey' do
      subject.top_up(1)
      expect { subject.touch_in(station) }.to change { subject.journey }
    end
  end

  describe '#touch_out' do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }

    it 'charges the Oystercard by minimum fare' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it 'adds a journey to journeys' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.journeys.length }.by(1)
    end

    it 'adds a journey to journeys in the form of a Hash' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys[0]).to be_instance_of(Hash)
    end

    it 'changes @journey from Journey to nil' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey).to be_nil
    end
  end

  describe '#deduct' do
    it 'deducts a fare from an Oystercard instance' do
      subject.top_up(20)
      expect(subject.send(:deduct_fare)).to eq(19)
    end
  end
end