require 'rubygems'
require 'arduino_firmata'

arduino = ArduinoFirmata.connect
# arduino.pin_mode 0, ArduinoFirmata::INPUT


# arduino.on :analog_read do |pin, value|
#   if pin == 0
#     puts "analog pin #{pin} changed: #{value}"
#   end
# end
#
# #

loop do
  light_level = arduino.analog_read 0
  # puts arduino.analog_read 0
  puts light_level
  # gon.light_level = light_level
  sleep 0.75
end


#
# loop do
#   value = arduino.anolog_read 0
#   puts value
#   sleep 0.5
# end
