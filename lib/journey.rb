class Journey
  attr_reader :touched_in, :touched_out

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = Station.new, exit_station = Station.new)
    @entry_station = entry_station
    @exit_station = exit_station
    @touched_in = false
    @touched_out = false
    @complete = false
  end

  def touch_in
    @touched_in = true
  end

  def touch_out
    @touched_out = true
  end

  def finalize(oystercard)
    return_fare
    oystercard.deduct_fare(@fare)
    print_complete
    set_complete
    oystercard.log(self)
  end

  private

  def return_fare
    if !@touched_in || !@touched_out
      @fare = PENALTY_FARE
    else 
      @fare = MINIMUM_FARE + (@entry_station.zone - @exit_station.zone).abs
    end
  end

  def print_complete
    print "Journey from #{@entry_station.name} to #{@exit_station.name} complete."
  end

  def set_complete
    @complete = true
  end
end