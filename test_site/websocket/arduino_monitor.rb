require 'faye/websocket'
require 'arduino_firmata'
require 'eventmachine'
require 'json'

def arduino_read
  arduino = ArduinoFirmata.connect
  arduino.pin_mode 8, ArduinoFirmata::INPUT
  light_level = arduino.analog_read 0
end

EM.run do
  ws = Faye::WebSocket::Client.new('ws://localhost:9292/foo')

  ws.on :open do |_event|
    p [:open]
    puts 'Message from client: Socket opened'
    ws.send({value: 'yay', channel: 'test'}.to_json)
  end

  ws.on :message do |event|
    puts 'Message from client: Message received'
    p [:message, event.data]
  end

  ws.on :error do |event|
    puts 'Error'
    p [:error, event]
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    puts 'Message from client: the socket has closed'
    ws = nil
  end

#   EM.add_periodic_timer(1) do
#     # (1..5).each {|n| ws.send(n)}
#     # ws.send("Something to be sent")
#
#     p 'sending'
#     ws.send(value: "YAY")
# #    ws.send({value: arduino_read})
# #    puts arduino_read
#
#
#     # (1..5).each {|n| puts "boo " + n.to_s}
#     # puts 'boo'
#   end
end
