xset r rate 200 40
xset s off
xset -dpms
setxkbmap -option caps:escape
setxkbmap -option compose:rctrl
xinput --disable 12
feh --bg-scale ~/Pictures/arch.png
~/xbanish/xbanish &
nm-applet &
exec i3
