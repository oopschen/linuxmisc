#!/usr/bin/env bash
# An i3wm term wrapper for personal usage.
# make st term run once and rezie by i3wm for_window rule, move to scratchpad
#

wm_instance=cmdterm
pattern_cmd_term="st.+\s$wm_instance\s"
mode=$1

## function definition
###
# @ reutnr 1 when proccess exists
function has_prog_started() {
    pname=$1
    res=$(pgrep -f $pname)
    if [ -z "$res" ]; then
        echo 0
    else
        echo 1
    fi

}

### The window display already
### @ return 1 when window is display
function i3wm_has_window_display() {
    path_res=$(i3-msg -t get_tree | \
        jq -c "path(..|.window_properties?|.instance?|select(.==\"$1\"))|.[:-2]")

    if [ 0 -eq $? ] && [ ! -z "$path_res" ]; then
        output_val=$(i3-msg -t get_tree | jq "getpath($path_res) | .output" | tr -d '"')
        if [ "$output_val" = "__i3" ]; then
            echo "1"
            return
        fi
    fi
    echo "0"
}

function i3wm_display_window() {
    i3-msg "[instance=\"(?i)$1\"] exec i3-move-position.sh cur-float-cmd-by-instance '(i?)$1' 60, resize set 40 ppt 90 ppt, scratchpad show"
}

function i3wm_indisplay_window() {
    i3-msg "[instance=\"(?i)$1\"] scratchpad show"
}

## function definition end

# query program started
# if has started: 
#   elif it is seen by user:
#       exit
#   else
#       make it seen by user
# else
#   start it 
#   make it seen by user
# 
#

has_prog_exists=$(has_prog_started "$pattern_cmd_term")
if [ "1" = "$has_prog_exists" ]; then
    has_window_display=$(i3wm_has_window_display "$wm_instance")
    if [ "1" = "$has_window_display" ];then
        echo "command term displays"
        i3wm_display_window "$wm_instance"
    else
        if [ "toggle" = "$mode" ]; then
            echo "toggle command term display"
            i3wm_indisplay_window "$wm_instance"
        else
            echo "command term already display $has_window_display"
        fi

    fi

else
    echo "command term launches..."
    nohup st -f \
        'MesloLGS NF:pixelsize=15:antialias=true:hinting:true:' \
        -n $wm_instance -e tmuxp load normal 2>&1 1>/dev/null &
fi
