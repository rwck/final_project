require 'rubygems'
require 'bundler/setup'
require 'puma'
require 'faye'
require 'faye/websocket'
require_relative 'websocket_server'

# use Faye::RackAdapter, :mount => '/faye', :timeout => 25

Faye::WebSocket.load_adapter('puma')

# run App



# require 'rubygems'
# require 'bundler/setup'
# require 'puma'
# require 'faye'
# require 'faye/websocket'
# require_relative 'websocket_server'
#
# Faye::WebSocket.load_adapter('Puma')
#
app = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
run app
