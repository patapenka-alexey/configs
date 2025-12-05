#!/usr/bin/env bash

SCRIPT_DIR="$( dirname -- "$BASH_SOURCE"; )";

sudo cp -r $SCRIPT_DIR /usr/share/icons/

sudo update-icon-caches /usr/share/icons/*


#sudo update-alternatives --install x-cursor-theme \
#    /usr/share/icons/mac-cursors/cursor.theme

#sudo update-alternatives --auto x-cursor-theme

