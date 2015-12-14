require 'rubygems'
require 'bundler/setup'
require_relative 'websocket_server'

Faye::WebSocket.load_adapter('puma')

run App
 
