#!/bin/sh

# colors from /etc/X11/rgb.txt
xsetroot -solid black
xset mouse default
xset r rate 200 50
xset b off
xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources

xscreensaver -nosplash &

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --widthtype percent --width 5 --transparent true --tint 0x000000 \
 --heighttype pixel --height 17 &

pasystray &
parcellite &
/usr/lib/notification-daemon/notification-daemon &
exec xmonad
