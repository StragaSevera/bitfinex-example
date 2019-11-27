# frozen_string_literal: true

class Event
  attr_accessor :type, :data

  # Forcing to use factory methods
  private_class_method :new

  def initialize(type, data)
    self.type = type
    self.data = data
  end

  class << self
    def candle(raw_data)
      if raw_data.first.is_a? Array
        candle_hist(raw_data)
      else
        candle_last(raw_data)
      end
    end

    private

    def candle_last(raw_data)
      data = candle_data(raw_data)
      new(:candle_last, data)
    end

    def candle_hist(raw_data)
      data = raw_data.map(&method(:candle_data))
      new(:candle_hist, data)
    end

    def candle_data(raw_data)
      {
        mts: raw_data[0],
        open: raw_data[1],
        close: raw_data[2],
        high: raw_data[3],
        low: raw_data[4],
        volume: raw_data[5]
      }
    end
  end
end
