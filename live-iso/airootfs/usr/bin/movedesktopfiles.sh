#!/bin/sh
desktoppath="$(xdg-user-dir DESKTOP)"
mv ~/{Home.desktop,trash.desktop} "$desktoppath"
rm ~/.config/autostart/movedesktopfiles.desktop
