class Oystercard
  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(value)
    raise 'Balance cannot be above 90' if exceeds_limit?(value)
    @balance += value
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise 'Insufficient funds' if insufficient_funds?
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct
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
end