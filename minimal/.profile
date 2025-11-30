if [[ -n $DISPLAY || $XDG_SESSION_TYPE ]]; then
    exec zsh
fi
