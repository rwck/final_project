require 'faye'

Faye::WebSocket.load_adapter('Puma')

app = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
run app
