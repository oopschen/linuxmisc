#!/usr/bin/env bash
### root wrapper for udev rule
su -w DISPLAY - work -c '~/.local/bin/hdmi-hotplug.sh'
su -w DISPLAY - work -c '~/.config/polybar/launch.sh'
