class Station

  ZONES = [1, 2, 3, 4]

  def initialize(name)
    @name = name
    @zone = assign_zone
  end

  def name
    @name
  end

  def zone
    @zone
  end

  private

  def assign_zone
    ZONES.sample
  end
end