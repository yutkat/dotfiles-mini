# Check for interactive bash and that we haven't already been sourced.
[ -z "$BASH_VERSION" -o -z "$PS1" -o -n "$BASH_COMPLETION" ] && return

# Check for recent enough version of bash.
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ $bmajor -gt 3 ] || [ $bmajor -eq 3 -a $bminor -ge 2 ]; then
    [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
        . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
    if shopt -q progcomp && [ -r ~/.bin/completion/bash_completion ]; then
        # Source completion code.
        . ~/.bin/completion/bash_completion
    fi
fi
unset bash bmajor bminor
