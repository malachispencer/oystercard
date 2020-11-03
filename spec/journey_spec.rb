require 'journey'

describe Journey do
  describe '#initialize' do
    let(:entry_station) { double('entry_station', :name => :neasden, :zone => 3) }

    it 'takes in an entry station as a parameter' do 
      journey = Journey.new(entry_station)
      expect(journey.entry_station.name).to eq(:neasden)
    end

    it 'sets exit station to nil initially' do
      journey = Journey.new(entry_station)
      expect(journey.exit_station).to be_nil
    end
  end

  describe '#add_exit_station' do
    let(:entry_station) { double('entry_station', :name => :neasden, :zone => 3) }
    let(:exit_station) { double('exit_station', :name => :westminster, :zone => 1) }

    it 'adds exit station to Journey' do
      journey = Journey.new(entry_station)
      journey.add_exit_station(exit_station)
      expect(journey.exit_station.name).to eq(:westminster)
    end
  end
end