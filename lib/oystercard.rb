require_relative './journey.rb'
require_relative './station.rb'

class Oystercard
  attr_reader :balance, :journey, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @journey = nil
    @journeys = []
  end

  def top_up(value)
    raise 'Balance cannot be above 90' if exceeds_limit?(value)
    @balance += value
  end

  def touch_in(station)
    raise 'Insufficient funds' if insufficient_funds?
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.add_exit_station(station)
    deduct_fare
    add_journey
    @journey = nil
  end

  private

  def exceeds_limit?(value)
    @balance + value > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct_fare
    @balance -= MINIMUM_FARE
  end

  def add_journey
    @journeys << { 
      @journey.entry_station => @journey.exit_station 
    }
  end
end