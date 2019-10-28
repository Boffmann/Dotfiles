#!/bin/bash

while :
do
    batteryPower=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}')

    batteryTimeToEmpty=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'time to empty' | awk '{print $4" "$5}')

    currentDate=$(date)
    WifiSSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d\: -f2)
    WifiSpeed=$(iwconfig wlp61s0 | egrep -o 'Bit Rate=[0-9]+.?[0-9]? [^ ]+' | cut -d\= -f2)

    echo "BAT:" $batteryPower $batteryTimeToEmpty "Left | WiFi:" $WifiSSID $WifiSpeed "|"  $currentDate
    sleep 1
done
