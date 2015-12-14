require 'faye/websocket'
require 'arduino_firmata'
require 'eventmachine'

def arduino_read
  arduino = ArduinoFirmata.connect
  arduino.pin_mode 8, ArduinoFirmata::INPUT
  light_level = arduino.analog_read 0
end

EM.run do
  ws = Faye::WebSocket::Client.new('ws://localhost:9292/foo')

  ws.on :open do |_event|
    p [:open]
    ws.send('Hello World from Websocket Client')
  end

  ws.on :message do |event|
    p [:message, event.data]
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end

  EM.add_periodic_timer(0.2) {
    (1..5).each {|n| ws.send(n)}
    ws.send(arduino_read.to_s)
    puts arduino_read.to_s
    (1..5).each {|n| puts "boo " + n.to_s}
    puts 'boo'
  }
end
