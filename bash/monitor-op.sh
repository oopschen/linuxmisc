#!/usr/bin/env bash

if [ 1 -ne  $# ];then
  echo -e "Usage:\t ./$(basename $0) [hdmi-on|hdmi-off|hdmi-mirror]"
  exit 1
fi

function query_monitor_name() {
  echo $(xrandr -q | grep -E '\bconnected\b' | grep -i $1 | cut -d ' ' -f 1)
}

mainMonitor=$(query_monitor_name edp)
externalMonitor=$(query_monitor_name hdmi)

case "$1" in
  hdmi-off)
    xrandr --output $externalMonitor --off
    ;;
  hdmi-on)
    xrandr --output $externalMonitor --auto --primary --above $mainMonitor
    ;;
  hdmi-mirror)
    xrandr --output $externalMonitor --auto --primary --same-as $mainMonitor
    ;;
  *)
    echo -e "Usage:\t ./$(basename $0) [hdmi-on|hdmi-off|hdmi-mirror]"
    exit 1
    ;;
esac
