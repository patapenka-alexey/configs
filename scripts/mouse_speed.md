#!/bin/bash -ex

1. found device_id
```bash
$ xinput --list --short
 ↳ A4TECH USB Device                       	id=23	[slave  pointer  (2)]
```


2. get property id
```bash
$ xinput --list-props $device_id | grep Accel
libinput Accel Speed (333):	0.000000
```

3. set value
```bash
xinput --set-prop 23 333 -0.5
```
