#!/bin/zsh
export PATH="${HOME}/.local/bin:${PATH}"

# Load resources
if [ -f ~/.Xresources ]; then
    xrdb -merge .Xresources
fi

# notification daemon
dunst &

# solarized background color
xsetroot -solid '#002b36'
 
# Fire up apps
unclutter -idle 5 -root &
nm-applet --sm-disable &
blueman-applet &

# load rc files
XSESSIONRCDIR=${XDG_CONFIG_HOME:-$HOME/.config}/xsession/rc.d
if [ -d "${XSESSIONRCDIR}" ]; then
    for RCFILE in ${XSESSIONRCDIR}/*; do
        source ${RCFILE}
    done
fi

# start window manager
exec /usr/bin/i3
