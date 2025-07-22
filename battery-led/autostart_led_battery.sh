!/bin/sh
# Load LED Battery Mod

# Minimal OS variable loading for performance
. /etc/profile.d/001-functions

function led_off() {
  n=1
  while [ "$n" -lt 4 ]; do
    echo 0 >  ${LED_PATH}/multi-ledl${n}/leds/rgb:l${n}/brightness
    echo 0 >  ${LED_PATH}/multi-ledr${n}/leds/rgb:r${n}/brightness
    echo 0 0 0 >  ${LED_PATH}/multi-ledl${n}/leds/rgb:l${n}/multi_intensity
    echo 0 0 0 >  ${LED_PATH}/multi-ledr${n}/leds/rgb:r${n}/multi_intensity
    n=$(( n + 1 ))
  done
}

chmod +x /storage/bin/battery_led_status_mod
mount --bind /storage/bin/battery_led_status_mod /usr/bin/battery_led_status

led_off
set_setting led.color battery
systemctl restart batteryledstatus.service
