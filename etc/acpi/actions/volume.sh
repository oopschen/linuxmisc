#!/bin/bash
amixercmd="amixer -q set"
amixer="$amixercmd Master"
[ -d /dev/snd ] && alsa=true || alsa=false

case "$1" in
    mute) 	
        if [ $alsa ]; then
            $amixer toggle
            dev="Headphone Speaker"
            for d in $dev
            do
                $amixercmd $d unmute
            done
        fi
        ;;
  volumeup) 	
      $alsa && $amixer 5dB+ ;;
  # volumedown
  *) 	$alsa && $amixer 5dB-;;
esac
