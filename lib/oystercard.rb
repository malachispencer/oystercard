class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(value)
    raise Exception.new 'Balance cannot be above 90' if exceeds_limit?
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  private

  def exceeds_limit?
    @balance >= MAX_BALANCE
  end
end