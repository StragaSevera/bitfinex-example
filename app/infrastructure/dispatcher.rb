# frozen_string_literal: true

require_relative '../config'
require_relative '../logic/event'
require 'bitfinex'

# Wrapper around outgoing requests, should be integration tested
class Dispatcher
  def initialize
    @client = Bitfinex::RESTv2.new(
      api_key: CONFIG[:api_key],
      api_secret: CONFIG[:api_secret]
    )
  end

  def dispatch(command)
    case command.type
    when :output
      puts command.params[:content]
      nil
    when :candle
      par = command.params
      Event.candle @client.candles(par[:symbol], par[:timeframe], par[:section])
    end
  end
end
