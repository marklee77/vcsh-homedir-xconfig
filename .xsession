#!/usr/bin/zsh -l

# Load resources
if [ -f ~/.Xresources ]; then
    xrdb -merge .Xresources
fi

# load rc files
XSESSIONRCDIR=${XDG_CONFIG_HOME:-$HOME/.config}/xsession/rc.d
if [ -d "${XSESSIONRCDIR}" ]; then
    for RCFILE in ${XSESSIONRCDIR}/*; do
        source ${RCFILE}
    done
fi

# start window manager
exec /usr/bin/i3
