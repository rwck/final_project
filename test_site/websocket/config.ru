require 'rubygems'
require 'bundler/setup'
require 'puma'
require 'faye'
require 'faye/websocket'
require 'logger'
require_relative 'echo_server'
require_relative 'sinatra_sockets'


Faye::WebSocket.load_adapter('puma')

Faye.logger = Logger.new(STDOUT)
# Faye.logger = Logger::INFO

use Faye::RackAdapter, :mount => '/foo', :timeout => 25



use MyChat::EchoServer

run MyChat::SinatraApp
