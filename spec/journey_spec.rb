require 'journey'

describe Journey do
  describe '#initialize' do
    it 'by default sets entry_station to nil' do
      expect(subject.entry_station).to be_nil
    end
  end
end