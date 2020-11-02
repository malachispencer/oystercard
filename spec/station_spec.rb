require 'station'

describe Station do
  describe '#initialize' do
    it 'makes the user to name the station' do
      station = Station.new('neasden')
      expect(station.name).to eq('neasden')
    end
  end
end