# frozen_string_literal: true

require 'rspec'
require 'infrastructure/dispatcher'

describe Dispatcher do
  it 'handles output command' do
    expect { subject.dispatch(Command.output('test')) }.to output("test\n").to_stdout
  end

  it 'handles candle command' do
    stub_request(:get, 'https://api.bitfinex.com/v2/candles/trade:1m:tBTCUSD/last')
      .to_return(body: [1_567_681_680_000, 10_642, 10_641, 10_642, 10_640, 3.49421483])

    event = subject.dispatch(Command.candle(timeframe: '1m', symbol: 'tBTCUSD', section: 'last'))

    expect(event.type).to eq :candle_last
    expect(event.data).to eq(
      mts: 1_567_681_680_000,
      open: 10_642, close: 10_641,
      high: 10_642, low: 10_640,
      volume: 3.49421483
    )
  end
end
