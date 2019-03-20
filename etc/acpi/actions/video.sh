#!/bin/bash

brdir="/sys/class/backlight/intel_backlight"
maxbrightness=$(cat ${brdir}/max_brightness)
curbrightness=$(cat ${brdir}/brightness)
step=$(echo "a=${maxbrightness}/10; if(a<=0) {a=1}; a" | bc)

case "$1" in
  brightnessup)
    val=$(echo "a=${curbrightness} + ${step};if (a > ${maxbrightness}) {a=${maxbrightness}}; a" | bc)
    echo $val > ${brdir}/brightness
    ;;

  # brightnessdown
  *)
    val=$(echo "a=${curbrightness} - ${step};if (a<0) {a = ${step}};a" | bc)
    cat ${brdir}/brightness
    echo $val > ${brdir}/brightness
    ;;
esac
