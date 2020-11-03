module Stations

  STATIONS = [
    {name: :'south kenton', zone: 4},
    {name: :'north wembley', zone: 4},
    {name: :'wembley central', zone: 4},
    {name: :'stonebridge park', zone: 3},
    {name: :harlesden, zone: 3},
    {name: :'willesden junction', zone: 3},
    {name: :'kensal green', zone: 2},
    {name: :"queen's park", zone: 2},
    {name: :'kilburn park', zone: 2},
    {name: :paddington, zone: 1},
    {name: :'baker street', zone: 1},
    {name: :'oxford circus', zone: 1}
  ]

  def self.get_station
    STATIONS.sample
  end
end