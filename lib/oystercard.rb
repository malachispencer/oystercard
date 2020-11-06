require_relative './journey.rb'
require_relative './station.rb'
require_relative './journey_log.rb'

class Oystercard
  attr_reader :balance

  MINIMUM_FARE = 1
  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize(journey_log = JourneyLog.new)
    @balance = DEFAULT_BALANCE
    @journey_log = journey_log
  end

  def top_up(value)
    raise 'Balance cannot be above 90' if exceeds_limit?(value)
    @balance += value
  end

  def touch_in(journey)
    raise 'Insufficient funds' if insufficient_funds?
    journey.card_touch_in
  end

  def touch_out(journey)
    journey.card_touch_out
  end

  def deduct_fare(fare)
    raise 'Card can only be charged for Journey' if !journey_action?
    @balance -= fare
  end

  def log(journey)
    raise 'Cannot manually add Journey' if !journey_action?
    @journey_log.add(journey)
  end

  def history
    @journey_log.display
  end

  private

  def exceeds_limit?(value)
    @balance + value > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def journey_action?
    caller[1][/`.*'/][1..-2] == 'finalize'
  end
end