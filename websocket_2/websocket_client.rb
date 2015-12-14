require 'faye/websocket'
require 'eventmachine'

EM.run {
  ws = Faye::WebSocket::Client.new('ws://localhost:9292/')

  ws.on :open do |event|
    p [:open]
    ws.send('Hello World from Websocket Client')
    # ws.ping

  end

  ws.on :message do |event|
    p [:message, event.data]
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}

