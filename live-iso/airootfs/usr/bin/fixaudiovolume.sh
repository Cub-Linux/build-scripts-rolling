#!/bin/sh
pactl set-sink-volume 0 100%
pactl set-sink-mute 0 0
pactl set-sink-input-volume 0 100%
pactl set-sink-input-mute 0 0
rm .config/autostart/fixaudiovolume.desktop
