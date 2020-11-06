require 'station'

describe Station do
  describe '#initialize' do
    it 'generates a station name by default' do
      expect(subject.name).to_not be_nil
    end

    it 'sets a zone from 1 to 4 by default' do
      expect(1..4).to include(subject.zone)
    end
  end
end