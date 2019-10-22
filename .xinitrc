xset r rate 200 40
xset s off
xset -dpms
setxkbmap -option caps:escape
setxkbmap -option compose:rctrl
~/xbanish/xbanish &
nm-applet &
compton &
exec i3
