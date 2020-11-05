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

  describe '#touch_in' do
    it 'raises an erroe unless invoked from Oystercard' do
      expect { subject.touch_in }.to raise_error('Cannot touch in without card')
    end
  end
end