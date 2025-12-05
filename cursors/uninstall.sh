#!/usr/bin/env bash

folders=$(ls -d */)

for folder in $folders
do
    echo Remove /usr/share/icons/$folder
    sudo rm -rf /usr/share/icons/$folder
done

# sudo update-alternatives --remove x-cursor-theme \
#     /usr/share/icons/mac-cursors/cursor.theme

