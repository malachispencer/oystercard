require 'stations'

describe Stations do
  describe '#get_station' do
    it 'returns a Hash of a station' do
      expect(subject.get_station).to be_instance_of(Hash)
    end
  end
end