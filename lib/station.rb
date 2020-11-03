require_relative '../modules/stations.rb'
include Stations

class Station
  def initialize
    @name = nil
    @zone = nil
    load_station
  end

  def name
    @name
  end

  def zone
    @zone
  end

  private

  def load_station
    this = Stations.get_random
    @name = this[:name]
    @zone = this[:zone]
  end
end