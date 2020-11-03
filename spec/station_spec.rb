require 'station'

describe Station do
  describe '#initialize' do
    it 'sets the name of a station' do
      expect(subject.name).to be_instance_of(Symbol)
    end

    it 'sets a valid zone, from 1 to 4' do
      expect(Station::ZONES).to include(subject.zone)
    end
  end
end