#!/bin/bash
export PATH="${HOME}/.local/bin:${PATH}"

# kill capslock and replasce with esc
setxkbmap gb -option inet:evdev -option caps:escape -option compose:menu

# Load resources
if [ -f ~/.Xresources ]; then
    xrdb -merge .Xresources
fi

# automount disks
udisks-glue
 
# solarized background color
xsetroot -solid '#002b36'
 
# Fire up apps
unclutter -idle 5 -root &
nm-applet --sm-disable &
gnome-sound-applet &
blueman-applet &
#pidgin &
#skype &
#dropbox start &
#vidalia &

laptop-powerd &

# load rc files
XSESSIONRCDIR=${XDG_CONFIG_HOME:-$HOME/.config}/xsession/rc.d
if [ -d "${XSESSIONRCDIR}" ]; then
    for RCFILE in ${XSESSIONRCDIR}/*; do
        source ${RCFILE}
    done
fi

# start window manager
exec /usr/bin/i3
