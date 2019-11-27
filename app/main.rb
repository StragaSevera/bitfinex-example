require_relative 'infrastructure/dispatcher'
require_relative 'logic/command'
require_relative 'logic/buisness_logic'

events = Queue.new
dispatcher = Dispatcher.new
buisness_logic = BuisnessLogic.new
events << dispatcher.dispatch(Command.candle(section: 'hist'))

until events.empty?
  command = buisness_logic.process(events.pop)
  event = dispatcher.dispatch(command)
  events << event unless event.nil?
end
