require 'journey_log'

describe JourneyLog do
  let(:journey_double) { double :journey_double }

  describe '#add' do
    it 'adds a journey to @journey_history' do
      subject.add(journey_double)
      expect(subject.display[0]).to eq(journey_double)
    end
  end

  describe '#display' do
    it 'returns the journeys from @journey_history' do 
      3.times { subject.add(journey_double) }
      journeys = subject.display

      journeys.each do |journey|
        expect(journey).to eq(journey_double)
      end
    end
  end
end