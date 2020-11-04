class Journey
  attr_reader :entry_station
  
  def initialize(entry_station = nil)
    @entry_station = nil
  end
end