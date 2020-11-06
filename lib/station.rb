require_relative '../modules/stations.rb'
include Stations

class Station
  def initialize(name = nil, zone = nil)
    @name = name
    @zone = zone
    load_station if uninitialized?
  end

  def name
    @name.to_sym
  end

  def zone
    @zone
  end

  private

  def uninitialized?
    [@name, @zone].any?(&:nil?)
  end

  def load_station
    this = Stations.get_random
    @name = this[:name]
    @zone = this[:zone]
  end
end