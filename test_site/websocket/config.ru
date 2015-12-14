require 'rubygems'
require 'bundler/setup'
require 'puma'
require 'faye'
require 'faye/websocket'
require_relative 'websocket_server'
require_relative 'sinatra_sockets'


Faye::WebSocket.load_adapter('puma')

use Faye::RackAdapter, :mount => '/foo', :timeout => 25

use MyChat::WebSocketServer

run MyChat::SinatraApp
