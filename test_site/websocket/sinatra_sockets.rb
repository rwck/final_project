require 'rubygems'
require 'sinatra'
require 'tilt/erb'
require 'arduino_firmata'
require 'gon-sinatra'
require 'sinatra/reloader' if development?

module MyChat
  class SinatraApp < Sinatra::Base

    arduino = ArduinoFirmata.connect
    arduino.pin_mode 8, ArduinoFirmata::INPUT

    register Gon::Sinatra

    Tilt.register Tilt::ERBTemplate, 'html.erb'

    # configure :production do
    enable :reloader

    set :environment, :development
    # set :environment, :production
    # set :bind, '192.168.1.2'



    get '/' do
      light_level = arduino.analog_read 0
      puts "The light level is currently #{light_level}"
      gon.light_level = light_level

      temperature_sensor_reading = arduino.analog_read 1
      puts "The temperature sensor reading is currently #{temperature_sensor_reading}"
      gon.temperature_sensor_reading = temperature_sensor_reading
      temperature = ((temperature_sensor_reading*5000)/1024)/100

      value = arduino.digital_read 8
      puts value
      if value == true
        text = "on"
      else
        text = "off"
      end

      gon.text = text
      puts "The switch is currently #{gon.text}"
      erb :index, :locals => {text: text, lightLevel: light_level, temperature: temperature}
    end

    get '/sockets' do
      # "Hello world"
      erb :sockets
    end



  end
end
