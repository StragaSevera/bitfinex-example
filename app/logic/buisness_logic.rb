# frozen_string_literal: true

class BuisnessLogic
  def process(event)
    case event.type
    when :candle_hist
      process_candle_hist(event)
    end
  end

  private

  # Outputting a candle with highest open price
  def process_candle_hist(event)
    candle = event.data.max_by { |c| c[:open] }
    Command.output(<<~HEREDOC
      MTS: #{candle[:mts]}
      Open: #{candle[:open]}
      Close: #{candle[:close]}
      High: #{candle[:high]}
      Low: #{candle[:low]}
      Volume: #{candle[:volume]}
    HEREDOC
                  )
  end
end
