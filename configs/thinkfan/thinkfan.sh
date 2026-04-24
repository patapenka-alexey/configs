#!/usr/bin/env bash

SCRIPT_DIR="$( dirname -- "$BASH_SOURCE"; )";

interactive_mode() {
    echo "=========================================" >&2
    echo "     ThinkFan Mode Selection" >&2
    echo "=========================================" >&2
    echo "1) FORCE  - Aggressive cooling (lower temps, higher noise)" >&2
    echo "2) MIDDLE - Balanced cooling (moderate temps & noise)" >&2
    echo "3) QUITE  - Quiet operation (higher temps, lower noise)" >&2
    echo "4) Cancel" >&2
    echo "=========================================" >&2
    echo -n "Select mode [1-4]: " >&2
    read -r choice

    case $choice in
        1|force|FORCE|f|F)
            echo "force"
            ;;
        2|middle|MIDDLE|m|M)
            echo "middle"
            ;;
        3|quite|QUITE|q|Q)
            echo "quite"
            ;;
        4|cancel|CANCEL|c|C)
            echo "cancel"
            ;;
        *)
            echo "invalid"
            ;;
    esac
}

# check for interactive mode if no argument provided
MODE=""
if [[ $# -eq 0 ]]; then
    MODE=$(interactive_mode)
    if [[ "$MODE" == "cancel" ]]; then
        echo "Operation cancelled."
        exit 0
    elif [[ "$MODE" == "invalid" ]]; then
        echo "Invalid selection. Please run again."
        exit 2
    fi
else
    MODE="$1"
fi

echo "Selected mode: $MODE"

#------------------------------------------------------------------------------
# install dependencies

SENSORS="$( dpkg -l | grep lm-sensors )"
if [[ "x$SENSORS" == "x" ]]; then
    echo "Installing lm-sensors..."
    sudo apt-get install lm-sensors
fi
THINKFAN="$( dpkg -l | grep thinkfan )"
if [[ "x$THINKFAN" == "x" ]]; then
    echo "Installing thinkfan..."
    sudo apt-get install thinkfan
fi
if test -f "/etc/thinkfan.conf"; then
    echo "Backing up existing configuration to /etc/thinkfan.conf.backup"
    sudo cp /etc/thinkfan.conf /etc/thinkfan.conf.backup
fi

#------------------------------------------------------------------------------
CONF_FILE="$SCRIPT_DIR/thinkfan.conf.tmp"

echo "tp_fan /proc/acpi/ibm/fan" > $CONF_FILE
echo "" >> $CONF_FILE

#------------------------------------------------------------------------------
# configure thermal devices
# the difference between PCs - number of the devices into
# /sys/devices/platform/coretemp.0/hwmon/hwmonX
HWMON_PATH="/sys/devices/platform/coretemp.0/hwmon"
if [ ! -d "$HWMON_PATH" ]; then
    echo "Error: $HWMON_PATH not found!"
    echo "Trying alternative path /sys/class/hwmon/"
    HWMON_PATH="/sys/class/hwmon"
fi

HWMON_DEVICE="$( ls $HWMON_PATH/ )"
if [ -z "$HWMON_DEVICE" ]; then
    echo "Error: No hwmon devices found!"
    rm $CONF_FILE
    exit 1
fi

for device in $( ls $HWMON_PATH/$HWMON_DEVICE/ | grep input )
do
    echo "hwmon $HWMON_PATH/$HWMON_DEVICE/$device" >> $CONF_FILE
done

# check if any sensors were found
SENSOR_COUNT=$(grep -c "^hwmon" $CONF_FILE)
if [ $SENSOR_COUNT -eq 0 ]; then
    echo "Error: No temperature sensors found!"
    cat $CONF_FILE
    rm $CONF_FILE
    exit 1
fi
echo "Found $SENSOR_COUNT temperature sensors"

#------------------------------------------------------------------------------
# configure fan mode
FORCE="
(0,	 0,	50)
(1,	48,	55)
(2,	53,	60)
(3,	58,	65)
(4,	63,	70)
(5,	68,	75)
(6,	73,	80)
(7,	78,	32767)
"

MIDDLE="
(0,	 0,	60)
(1,	57,	65)
(2,	60,	70)
(3,	65,	75)
(4,	70,	77)
(5,	75,	83)
(6,	80,	88)
(7,	85,	32767)
"

QUITE="
(0,	 0,	64)
(1,	62,	68)
(2,	66,	72)
(3,	70,	76)
(4,	74,	80)
(5,	78,	84)
(6,	82,	88)
(7,	86,	32767)
"

if [[ "x$MODE" == "xforce" ]]; then
    echo "White Force profile to the thinkfan.conf..."
    echo """$FORCE""" >> $CONF_FILE
elif [[ "x$MODE" == "xmiddle" ]]; then
    echo "White Middle profile to the thinkfan.conf..."
    echo """$MIDDLE""" >> $CONF_FILE
elif [[ "x$MODE" == "xquite" ]]; then
    echo "White Quite profile to the thinkfan.conf..."
    echo """$QUITE""" >> $CONF_FILE
else
    echo "Undefined profile name! Exit..."
    rm $CONF_FILE
    exit 2
fi

#------------------------------------------------------------------------------
sudo cp $CONF_FILE /etc/thinkfan.conf
sudo systemctl restart thinkfan.service

rm $CONF_FILE

echo "========================================="
echo "Success! ThinkFan is now running in $MODE mode"
echo "========================================="
echo "Check status with: sudo systemctl status thinkfan"
echo "Monitor temps with: sensors"
