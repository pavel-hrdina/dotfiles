#!/bin/bash

WAYBAR_FOLDER="$HOME/.config/waybar/"
CONFIG_PATH="$WAYBAR_FOLDER/config"
STYLE_PATH="$WAYBAR_FOLDER/style.css"
# space-separated string of files to watch
CONFIG_FILES="$CONFIG_PATH $STYLE_PATH"

trap "killall waybar" EXIT

while true; do
	waybar --config $CONFIG_PATH --style $STYLE_PATH >$WAYBAR_FOLDER/.waybar.err 2>&1 &
	inotifywait -e create,modify $CONFIG_FILES
	killall waybar 2>/dev/null
done
