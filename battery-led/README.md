# Battery LED Status Mod


## Overview

This is a little tweak that changed the default led battery indicator service script.

**Mode: Discharching**

| Level | LED |
|-------|-----|
| <=5   | Red flashing |
| <=10  | Red |
| <=20  | Yellow |
| >20   | Off |

**Mode: Charging**

| Level | LED |
|-------|-----|
| <=94  | Orange |
| >94   | Green |

After a reboot the default led service script will always load up first before it is replaced with this mod. So for example if the battery is charged above 40% both sticks will light up green for a second before the will turn off.


## Installation

Copy `autostart_led_battery.sh` into `/storage/.config/autostart/` and make it executable `chmod +x /storage/.config/autostart/autostart_led_battery.sh`.

Create a new binary folder (`mkdir -p /storage/bin`) and copy the modded service executeable `battery_led_status_mod` to this location.

### Further Modifications?

If you want only one stick to light up you can easily modify the service script to do this.


Open up `battery_led_status_mod` and comment out the stick you don't want to light up in every color function (except `led_off()`):

In this example i only want the right stick to light up in the RED led color so i uncomment the lines which setup the left stick led (`leds/rgb:l`)

```bash
function bat_led_red() {
  n=1
  while [ "$n" -lt 4 ]; do
    #echo 50 >  ${LED_PATH}/multi-ledl${n}/leds/rgb:l${n}/brightness
    echo 50 >  ${LED_PATH}/multi-ledr${n}/leds/rgb:r${n}/brightness
    #echo 0 0 255 >  ${LED_PATH}/multi-ledl${n}/leds/rgb:l${n}/multi_intensity
    echo 0 0 255 >  ${LED_PATH}/multi-ledr${n}/leds/rgb:r${n}/multi_intensity
    n=$(( n + 1 ))
  done
}
```
