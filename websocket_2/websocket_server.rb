require 'rubygems'
require 'faye/websocket'

App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :message do |event|
      ws.send(event.data)
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end

    return ws.rack_response

    # ws.ping 'Mic check, one, two' do
      # fires when pong is received
    # end

  else
    return [200, { 'Content-Type' => 'text/plain' }, ["bob"]]
  end
end

