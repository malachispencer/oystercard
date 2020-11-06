require 'station'

describe Station do
  describe '#initialize' do
    let(:custom_station) { Station.new('neasden', 3) }

    it 'generates a station name by default' do
      expect(subject.name).to_not be_nil
    end

    it 'sets a zone from 1 to 4 by default' do
      expect(1..4).to include(subject.zone)
    end

    it 'allows user to set a name' do
      expect(custom_station.name).to eq(:neasden)
    end

    it 'allows user to set a zone' do
      expect(custom_station.zone).to eq(3)
    end
  end
end