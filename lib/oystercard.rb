class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(value)
    raise Exception.new 'Balance cannot be above 90' if exceeds_limit?
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise Exception.new 'Insufficient funds' if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceeds_limit?
    @balance >= MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end
end