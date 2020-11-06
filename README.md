# Oystercard

## About

Makers week 2 pair programming challenge where we emulate London's Oystercard system.

## How to run

```shell
irb -r ./lib/oystercard.rb
```

## Features

1) Create an Oystercard.

2) Top up Oystercard.

3) Create a Journey. Entry and exit stations are randomly generated Station objects with name and zone by default, or user can 
   create their own custom Stations with name and zone, then enter these for their Journey entry and exit stations.

4) Touch in for Journey, touch out for Journey.

5) Finalize Journey, fares are calculated according to 1 minimum, plus 1 for every zone crossed e.g. zone 1 to 3 = £3, zone 1 to 4 = £4.

6) If a Journey is finalized but the card was not used to touch in or touch out, the fare is charged at £6.
