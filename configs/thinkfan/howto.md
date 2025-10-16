https://thinkwiki.de/Thinkfan       - basic page on german  
http://ubuntu.fliplinux.com/151.html  
https://losst.ru/upravlenie-kulerom-linux

```bash
$ sudo apt-get install lm-sensors

$ sudo sensors-detect
"Do you want to add these lines automatically to /etc/modules? (yes/NO)" --- YOU SHOULD ANSWER `YES` !!!
```
add service to autoload
```bash
$ sudo systemctl enable lm_sensors default
```
start it
```bash
$ sudo systemctl start lm_sensors
```
how to see information
```bash
$ sensors
```
install tool
```bash
$ sudo apt-get install thinkfan

$ echo "options thinkpad_acpi fan_control=1" | sudo tee /etc/modprobe.d/thinkfan.conf

$ sudo systemctl start module-init-tools
```
add line `START=yes` to
```bash
$ sudo vim /etc/default/thinkfan
```
add servive to autoload
```bash
$ systemctl enable thinkfan.service
```
change lines with devices
```bash
sudo vim /etc/thinkfan.conf
hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp2_input
hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input
```

and set required speed:
```
version 1
(0,	0,	60)
(1,	57,	65)
(2,	59,	66)
(3,	64,	75)
(4,	68,	77)
(5,	71,	78)
(7,	73,	32767)

version 2
(0,	0,	60)
(1,	57,	65)
(2,	60,	70)
(3,	65,	75)
(4,	70,	77)
(5,	75,	83)
(7,	80,	32767)

version 3
(0,	0,	62)
(1,	0,	62)
(2,	56,	68)
(3,	62,	70)
(4,	65,	74)
(5,	69,	82)
(7,	75,	32767)
```

```bash
sudo systemctl start thinkfan
sudo systemctl stop thinkfan
```
