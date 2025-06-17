#!/bin/bash -ex

echo Pass 0 or 1 as script parameter to 'turn on' or 'turn off' the touchpad

id=$(xinput | grep Touch[pP]ad | cut -f2 -d= | awk '{print $1}')
echo Touchpad id=$id

if [ "x$1" = "x0" ]; then
    echo Try to turn off the device
else
    echo Try to turn on the device
fi

xinput set-prop $id 'Device Enabled' $1
