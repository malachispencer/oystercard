class Oystercard
  attr_reader :balance, :entry_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @journeys = []
  end

  def top_up(value)
    raise 'Balance cannot be above 90' if exceeds_limit?(value)
    @balance += value
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    raise 'Insufficient funds' if insufficient_funds?
    @entry_station = station
  end

  def touch_out(station)
    deduct
    add_journey(station)
    @entry_station = nil
  end

  private

  def exceeds_limit?(value)
    @balance + value > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct
    @balance -= MINIMUM_FARE
  end

  def add_journey(exit_station)
    @journeys << { :@entry_station => :exit_station }
  end
end