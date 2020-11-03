require_relative '../modules/stations.rb'

describe Stations do
  describe '#get_random' do
    it 'returns a station in the form of a hash' do
      expect(subject.get_random).to be_instance_of(Hash)
    end
  end
end