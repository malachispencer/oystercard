class Journey
  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finalize(exit_station)
    add_exit_station(exit_station)
    calculate_fare
  end

  private

  def add_exit_station(exit_station)
    @exit_station = exit_station
  end

  def calculate_fare
    @fare = MINIMUM_FARE
  end
end