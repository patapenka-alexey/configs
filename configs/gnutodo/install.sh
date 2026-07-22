#!/usr/bin/env bash

SCRIPT_DIR="$( dirname -- "$BASH_SOURCE"; )";

ZSH="$( dpkg -l | grep zsh )"
if [[ "x$ZSH" == "x" ]]; then
    sudo apt-get install zsh
fi

INSTALL_DIR=~/.local/bin/

if [ ! -f "$INSTALL_DIR/gtd" ]; then
    cp $SCRIPT_DIR/gtd $INSTALL_DIR/gtd
    chmod +x $INSTALL_DIR/gtd
fi

TODO_FILE=~/Documents/todo.txt

if [ ! -f $TODO_FILE ]; then
    touch $TODO_FILE
fi
