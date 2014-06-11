#!/bin/bash

# kill capslock and replasce with esc
#setxkbmap gb -option inet:evdev -option caps:escape -option compose:menu

# Load resources
if [ -f ~/.Xresources ]; then
    xrdb -merge .Xresources
fi

# gnome keyring --
for VARVAL in $(gnome-keyring-daemon --components=ssh,gpg,secrets,pkcs11 --start); do
    export ${VARVAL}
done

# automount disks
udisks-glue
 
# Set the background color
# solarized color
xsetroot -solid '#002b36'
 
# notification daemon
${HOME}/Programs/base/bin/dunst &

# Fire up apps
xscreensaver -no-splash &
unclutter -idle 5 -root &
#pidgin &
#skype &
nm-applet --sm-disable &
#gnome-sound-applet &
blueman-applet &
dropbox start &
#vidalia &

# start window manager
exec /usr/bin/i3
