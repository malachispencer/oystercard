require 'oystercard'

describe Oystercard do
  context 'Class' do
    it 'returns an instance of an Oystercard' do
      expect(subject).to be_instance_of(Oystercard)
    end
  end
  
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
      subject.top_up(Oystercard::MAX_BALANCE)
      expect { subject.top_up(1) }.to raise_error(Exception, 'Balance cannot be above 90')
    end

    context '#deduct' do
      it 'can be called on an Oystercard instance' do
        expect(subject).to respond_to(:deduct).with(1).argument
      end

      it 'deducts a fare from an Oystercard instance' do
        expect { subject.deduct(1) }.to change { subject.balance }.by(-1)
      end
    end

    context '#in_journey?' do
      it 'can be called on an Oystercard instance' do
        expect(subject).to respond_to(:in_journey?)
      end

      it 'returns a boolean value' do
        expect(subject.in_journey?).to eq(false).or eq(true)
      end
    end

    context '#touch_in' do
      it 'can be called on an Oystercard instance' do
        expect(subject).to respond_to(:touch_in)
      end

      it 'changes in_journey instance variable from false to true' do
        subject.top_up(5)
        subject.touch_in
        expect(subject.in_journey?).to eq(true)
      end

      it 'raises an exception if balance is below 1' do
        expect { subject.touch_in }.to raise_error(Exception, 'Insufficient funds')
      end
    end

    context '#touch_out' do
      it 'can be called on an Oystercard instance' do
        expect(subject).to respond_to(:touch_out)
      end

      it 'changes in_journey instance variable from true to false' do
        subject.top_up(5)
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey?).to eq(false)
      end
    end
  end
end