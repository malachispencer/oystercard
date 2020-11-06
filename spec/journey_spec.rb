require 'journey'

describe Journey do
  describe '#initialize' do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :entry_station }
    let(:journey) { Journey.new(entry_station, exit_station) }

    it 'allows the user to enter an entry station' do
      expect(journey.entry_station).to eq(entry_station)
    end

    it 'allows the user to enter an exit station' do
      expect(journey.exit_station).to eq(exit_station)
    end

    it 'initially has touched_in set to false' do
      expect(subject.touched_in).to eq(false)
    end

    it 'initially has touch_out set to false' do
      expect(subject.touched_out).to be_instance_of(FalseClass)
    end
  end

  describe '#card_touch_in' do
    it 'raises an error unless invoked from Oystercard' do
      expect { subject.card_touch_in }.to raise_error('Cannot touch in without card')
    end

    it 'changes @touched_in from false to true' do
      allow(subject).to receive(:card_action?) { true }
      expect { subject.card_touch_in }.to change { subject.touched_in }.from(false).to(true)
    end
  end

  describe '#card_touch_out' do
    it 'raises an error unless invoked from Oystercard' do
      expect { subject.card_touch_out }.to raise_error('Cannot touch out without card')
    end

    it 'changes @touched_out from false to true' do
      allow(subject).to receive(:card_action?) { true }
      expect { subject.card_touch_out }.to change { subject.touched_out }.from(false).to(true)
    end
  end

  describe '#finalize' do
    let(:oystercard) { double('oystercard', deduct_fare: nil, log: nil) }
    let(:entry_station) { double('entry_station', name: :neasden, zone: 3) }
    let(:exit_station) { double('exit_station', name: :westminster, zone: 1) }
    let(:journey) { Journey.new(entry_station, exit_station) }

    it 'raises an error if the Journey is already finalized' do
      subject.finalize(oystercard)
      expect { subject.finalize(oystercard) }.to raise_error('Journey already finalized')
    end

    it "sets @incomplete to false for complete journey's" do
      allow(journey).to receive(:card_action?) { true }
      journey.card_touch_in
      journey.card_touch_out
      expect { journey.finalize(oystercard) }.to change { journey.incomplete }.from(true).to(false)
    end

    it 'calculates the fare of a complete Journey' do
      allow(journey).to receive(:card_action?) { true }
      journey.card_touch_in
      journey.card_touch_out
      expect { journey.finalize(oystercard) }.to change { journey.fare }.from(nil).to(3)
    end

    it 'calculates the fare of an incomplete Journey' do
      allow(journey).to receive(:card_action?) { true }
      journey.card_touch_in
      expect { journey.finalize(oystercard) }.to change { journey.fare }.from(nil).to(6)
    end

    it 'lets user know journey is complete' do
      expect { journey.finalize(oystercard) }.to output('Journey from neasden to westminster complete.').to_stdout
    end
  end
end