xset r rate 200 40
xset s off
xset -dpms
setxkbmap -option caps:escape
setxkbmap -option compose:rctrl
xinput --disable 12
~/xbanish/xbanish &
nm-applet &
compton &
exec i3
