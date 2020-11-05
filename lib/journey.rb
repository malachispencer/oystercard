class Journey
  attr_reader :entry_station, :exit_station, :fare
  attr_reader :touched_in, :touched_out, :incomplete

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = Station.new, exit_station = Station.new)
    @entry_station = entry_station
    @exit_station = exit_station
    @touched_in = false
    @touched_out = false
    @incomplete = true
    @finalized = false
  end

  def card_touch_in
    raise 'Cannot touch in without card' if not_card_action?
    @touched_in = true
  end

  def card_touch_out
    raise 'Cannot touch out without card' if not_card_action?
    @touched_out = true
  end

  def finalize(oystercard)
    raise 'Journey already finalized' if finalized?
    set_complete
    return_fare
    oystercard.deduct_fare(@fare)
    print_complete
    set_finalized
    oystercard.log(self)
  end

  private

  def not_card_action?
    !%w[touch_in touch_out].include? caller[0][/`.*'/][1..-2]
  end

  def return_fare
    @fare = @incomplete ? 
      PENALTY_FARE : 
        MINIMUM_FARE + (@entry_station.zone - @exit_station.zone).abs
  end

  def print_complete
    print "Journey from #{@entry_station.name} to #{@exit_station.name} complete."
  end

  def set_complete
    @incomplete = !@touched_in || !@touched_out
  end

  def set_finalized
    @finalized = true
  end

  def finalized?
    @finalized == true
  end
end