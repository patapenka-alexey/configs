#!/bin/bash -ex

setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle

# to swap `CapsLock` and `Esc` buttons
#setxkbmap -option caps:swapescape

# to make `CapsLock` additional `Esc` button
setxkbmap -option caps:escape

# to swap `CapsLock` and `Windows` button
#setxkbmap -option caps:super

