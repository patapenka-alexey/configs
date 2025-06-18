#!/usr/bin/env bash

SCRIPT_DIR="$( dirname -- "$BASH_SOURCE"; )";

sudo cp -r $SCRIPT_DIR /usr/share/icons/

sudo update-icon-caches /usr/share/icons/*

