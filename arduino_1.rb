require 'rubygems'
require 'arduino_firmata'

arduino = ArduinoFirmata.connect

puts "Firmata version #{arduino.version}"

# loop do
#   arduino.digital_write 13, true
#   sleep 0.2
#   arduino.digital_write 13, false
#   sleep 0.5
# end

arduino.pin_mode 8, ArduinoFirmata::INPUT

loop do
  if arduino.digital_read 8
    puts "pin 8 on"
  else
    puts "pin 8 off"
  end
end

# loop do
#   20.times do
#     arduino.digital_write 13, true
#     sleep 0.5
#   end
#   20.times do
#     arduino.digital_write 13, true
#     sleep 0.2
#   end
# end
