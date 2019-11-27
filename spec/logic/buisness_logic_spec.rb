# frozen_string_literal: true

require 'rspec'
require 'logic/buisness_logic'

describe BuisnessLogic do
  it 'processes history event' do
    sut = BuisnessLogic.new
    command = sut.process(
      Event.candle(
        [
          [1_573_562_880_000, 0.0003, 0.0003, 0.0003, 0.0003, 24_083.8638948],

          [1_573_562_820_000, 0.00030178, 0.00033105, 0.00033105, 0.00030178, 1840.0074507599998]
        ]
      )
    )
    expect(command.type).to eq :output
    expect(command.params).to eq(content: <<~HEREDOC
      MTS: 1573562820000
      Open: 0.00030178
      Close: 0.00033105
      High: 0.00033105
      Low: 0.00030178
      Volume: 1840.0074507599998
    HEREDOC
                                )
  end
end
