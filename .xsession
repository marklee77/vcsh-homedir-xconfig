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

export PATH="${HOME}/.local/bin:${PATH}"
exec supervisord -n -c ${XDG_CONFIG_HOME:-${HOME}/.config}/supervisord/supervisord.conf
