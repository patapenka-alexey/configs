#!/bin/bash -ex

# Lenovo ThinkPad Compact USB Keyboard with TrackPoint      id=12   [slave  pointer  (2)]

echo Pass value of the Speed as script parameter, or default value '-0.35' will be applied

devices=$(xinput | grep -e 'TrackPoint' -e 'Keyboard Mouse' | cut -f2 -d= | awk '{print $1}')

value=-0.35

if [ "x$1" != "x" ]; then
    value=$1
fi
echo Apply value "$value"

for device in $devices
do
    echo Set $device 'libinput Accel Speed' to $value
    xinput set-prop $device 'libinput Accel Speed' $value
    continue
done

# for Tex Shinobi it could be "USB-HID Keyboard Mouse"

