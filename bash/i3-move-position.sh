#!/usr/bin/env bash

mode=$1
criteria=$2
msg=""

case $mode in 
    float-cmd)
        pos_info=$(xrandr | grep primary | cut -d ' ' -f 4)
        pos_x=$(echo "$pos_info" | cut -d '+' -f 2)
        pos_y=$(echo "$pos_info" | cut -d '+' -f 3)

        display_info=$(echo "$pos_info" | cut -d '+' -f 1)
        display_width=$(echo "$display_info" | cut -d 'x' -f 1)
        display_height=$(echo "$display_info" | cut -d 'x' -f 2)

        dst_pos_x=$(python -c "import math;print(math.ceil($pos_x + 0.6 * $display_width))")
        dst_pos_y=$(echo "$pos_y + 5" | bc)
        msg="[class=\"$criteria\"] move position $dst_pos_x $dst_pos_y"
        echo  $msg > /tmp/c
        ;;
    *)
        echo -e "support mode: float-cmd"
        exit 1
esac

i3-msg "$msg"
