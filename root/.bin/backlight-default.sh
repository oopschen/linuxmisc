#!/usr/bin/env bash
#

bdir=$1
backlightbasedir=${bdir:=/sys/class/backlight/intel_backlight}

def_val=$(echo "$(cat $backlightbasedir/max_brightness) * 45 / 100" | bc)
echo $def_val > $backlightbasedir/brightness
