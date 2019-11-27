# frozen_string_literal: true

require 'rspec'
require 'logic/command'

describe Command do
  it 'can create candle command' do
    sut = Command.candle(timeframe: '5m', symbol: 'tBTCUSD', section: 'last')
    expect(sut.type).to eq(:candle)
    expect(sut.params).to eq(timeframe: '5m', symbol: 'tBTCUSD', section: 'last')
  end

  it 'can create candle command with defaults' do
    sut = Command.candle
    expect(sut.type).to eq(:candle)
    expect(sut.params).to eq(timeframe: '1m', symbol: 'tBTCUSD', section: 'last')
  end

  it 'can create output command' do
    sut = Command.output('text')
    expect(sut.type).to eq(:output)
    expect(sut.params).to eq(content: 'text')
  end
end
