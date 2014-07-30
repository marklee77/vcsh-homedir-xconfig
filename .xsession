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

#eval $(gpg-agent --daemon)
#keyring get gpg-sign mark@stillwell.me | /usr/lib/gnupg2/gpg-preset-passphrase --preset E82490B8A4A70D8BA4EE5E77F134413A0E82B3EF
#keyring get gpg-encrypt mark@stillwell.me | /usr/lib/gnupg2/gpg-preset-passphrase --preset D80DE6DAFB42093D53D8C250C15F1D950BD03706
#keyring get gpg-auth mark@stillwell.me | /usr/lib/gnupg2/gpg-preset-passphrase --preset 5857F9F1819B9881165DD3AA1CF770581DCCA197
#keyring get gpg-auth mark@stillwell.me | /usr/lib/gnupg2/gpg-preset-passphrase --preset 562AEE25E2049CB24A8C11B05C9377A715A399DA

# automount disks
udisks-glue
 
# solarized background color
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
