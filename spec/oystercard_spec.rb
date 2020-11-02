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
  end
end