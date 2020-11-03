require 'journey'

describe Journey do
  describe '#initialize' do
    it 'takes in an entry station as a parameter' do 
      entry_station = double('entry_station', :name => :neasden, :zone => 3)
      subject { Journey.new(entry_station) }
      expect(subject.entry_station.name).to eq(:neasden)
    end
  end

end