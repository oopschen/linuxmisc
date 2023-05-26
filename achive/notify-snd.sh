#! /usr/bin/env bash

mpv --really-quiet /opt/notify.mp3
notify-send -u normal Pomodoro "$1 $2"
