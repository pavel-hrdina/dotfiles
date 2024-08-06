#!/bin/bash

battery_percentage=$(acpi -b | grep -P -o '[0-9]+(?=%)')
battery_status=$(acpi -b | grep -P -o '\w+(?=,)')

if [ "$battery_status" = "Charging" ]; then
  icon="󰂄"
  class="charging"
elif [ "$battery_percentage" -ge 90 ]; then
  icon="󰁹"
  class="high"
elif [ "$battery_percentage" -ge 80 ]; then
  icon="󰂂"
  class="high"
elif [ "$battery_percentage" -ge 70 ]; then
  icon="󰂁"
  class="high"
elif [ "$battery_percentage" -ge 60 ]; then
  icon="󰂀"
  class="medium"
elif [ "$battery_percentage" -ge 50 ]; then
  icon="󰁿"
  class="medium"
elif [ "$battery_percentage" -ge 40 ]; then
  icon="󰁾"
  class="medium"
elif [ "$battery_percentage" -ge 30 ]; then
  icon="󰁽"
  class="low"
elif [ "$battery_percentage" -ge 20 ]; then
  icon="󰁼"
  class="low"
elif [ "$battery_percentage" -ge 10 ]; then
  icon="󰁻"
  class="critical"
else
  icon="󰁺"
  class="critical"
fi

echo "{\"icon\": \"$icon\", \"percentage\": $battery_percentage, \"class\": \"$class\"}"
