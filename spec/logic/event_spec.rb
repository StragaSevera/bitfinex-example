# frozen_string_literal: true

require 'rspec'
require 'logic/event'

describe Event do
  it 'can create candle_last event' do
    sut = Event.candle([1_567_681_680_000, 10_642, 10_641, 10_642, 10_640, 3.49421483])
    expect(sut.type).to eq :candle_last
    expect(sut.data).to eq(
      mts: 1_567_681_680_000,
      open: 10_642, close: 10_641,
      high: 10_642, low: 10_640,
      volume: 3.49421483
    )
  end

  it 'can create candle_hist event' do
    sut = Event.candle(
      [
        [1_573_562_880_000, 0.0003, 0.0003, 0.0003, 0.0003, 24_083.8638948],

        [1_573_562_820_000, 0.00030178, 0.00033105, 0.00033105, 0.00030178, 1840.0074507599998]
      ]
    )
    expect(sut.type).to eq :candle_hist
    expect(sut.data[0]).to eq(
      mts: 1_573_562_880_000,
      open: 0.0003, close: 0.0003,
      high: 0.0003, low: 0.0003,
      volume: 24_083.8638948
    )
    expect(sut.data[1]).to eq(
      mts: 1_573_562_820_000,
      open: 0.00030178, close: 0.00033105,
      high: 0.00033105, low: 0.00030178,
      volume: 1840.0074507599998
    )
  end
end
