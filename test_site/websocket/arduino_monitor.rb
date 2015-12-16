require 'faye/websocket'
require 'arduino_firmata'
require 'eventmachine'
require 'json'

def arduino_read_light
  arduino = ArduinoFirmata.connect
  # arduino.pin_mode 8, ArduinoFirmata::INPUT
  light_level = arduino.analog_read 0
end

def arduino_read_temp
  arduino = ArduinoFirmata.connect
  temp_level = arduino.analog_read 1
end


EM.run do
  ws = Faye::WebSocket::Client.new('ws://localhost:9292/faye')

  ws.on :open do |_event|
    p [:open]
    puts 'Message from client: Socket opened'
    # ws.send({ligh}.to_json)
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

  EM.add_periodic_timer(0.5) do

    if ws
      p 'sending'

      ws.send({data: {light: arduino_read_light, temp: arduino_read_temp}, channel: '/arduino' }.to_json)
      end
  end
end
