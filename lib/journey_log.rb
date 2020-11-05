class JourneyLog
  def initialize
    @journey_history = []
  end

  def add(journey)
    @journey_history.push(journey)
  end

  def display
    @journey_history.dup
  end
end