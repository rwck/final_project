require 'faye/websocket'

module MyChat

  class WebSocketServer

    def initialize(app)
      @app = app
    end

    def call(env)
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

      else
        @app.call(env)
      end
    end
  end
end
