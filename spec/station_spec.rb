require 'station'

describe Station do
  describe '#initialize' do
    it 'makes the user name the station' do
      station = Station.new('neasden')
      expect(station.name).to eq('neasden')
    end

    it 'randomly assigns zone between 1 and 4' do
      station = Station.new('neasden')
      expect(1..4).to include(station.zone)
    end
  end
end