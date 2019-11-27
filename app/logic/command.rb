# frozen_string_literal: true

# TODO: Subclass, add validation, separate UI and web commands
class Command
  attr_accessor :type, :params

  # Forcing to use factory methods
  private_class_method :new

  def initialize(type, params)
    self.type = type
    self.params = params
  end

  class << self
    def candle(timeframe: '1m', symbol: 'tBTCUSD', section: 'last')
      new(:candle, timeframe: timeframe, symbol: symbol, section: section)
    end

    def output(content)
      new(:output, content: content)
    end
  end
end
