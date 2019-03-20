#!/bin/bash
amixer="amixer -q set Master"
[ -d /dev/snd ] && alsa=true || alsa=false

case "$1" in
  mute) 		$alsa && $amixer toggle;;
  volumeup) 	$alsa && $amixer 5dB+;;
  # volumedown
  *) 	$alsa && $amixer 5dB-;;
esac
