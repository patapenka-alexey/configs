#!/usr/bin/env bash

SCRIPT_DIR="$( dirname -- "$BASH_SOURCE"; )";

NVIM_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_DIR" ]; then
    BACKUP="$NVIM_DIR.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $NVIM_DIR to $BACKUP"
    mv "$NVIM_DIR" "$BACKUP"
fi

mkdir -p "$NVIM_DIR"

cp "$SCRIPT_DIR/init.lua" "$NVIM_DIR/"
cp -r "$SCRIPT_DIR/autoload" "$NVIM_DIR/"
cp -r "$SCRIPT_DIR/colors" "$NVIM_DIR/"
cp -r "$SCRIPT_DIR/lua" "$NVIM_DIR/"