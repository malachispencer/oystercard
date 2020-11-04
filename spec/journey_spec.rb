require 'journey'

describe Journey do
  describe '#initialize' do
    let(:station) { double :station }

    it 'by default sets entry_station to nil' do
      expect(subject.entry_station).to be_nil
    end

    it 'allows a station to be passed in' do
      journey = Journey.new(station)
      expect(journey.entry_station).to eq(station)
    end
  end
end