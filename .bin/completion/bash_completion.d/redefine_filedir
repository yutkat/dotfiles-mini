# This is a copy of the _filedir function in bash_completion, included
# and (re)defined separately here because some versions of Adobe Reader,
# if installed, are known to override this function with an incompatible
# version, causing various problems.
#
# https://bugzilla.redhat.com/677446
# http://forums.adobe.com/thread/745833

_filedir()
{
    local i IFS=$'\n' xspec

    _tilde "$cur" || return 0

    local -a toks
    local quoted tmp

    _quote_readline_by_ref "$cur" quoted
    toks=( ${toks[@]-} $(
        compgen -d -- "$quoted" | {
            while read -r tmp; do
                printf '%s\n' $tmp
            done
        }
    ))

    if [[ "$1" != -d ]]; then
        [[ ${BASH_VERSINFO[0]} -ge 4 ]] && \
            xspec=${1:+"!*.@($1|${1^^})"} || \
            xspec=${1:+"!*.@($1|$(printf %s $1 | tr '[:lower:]' '[:upper:]'))"}
        toks=( ${toks[@]-} $( compgen -f -X "$xspec" -- $quoted) )
    fi
    [ ${#toks[@]} -ne 0 ] && _compopt_o_filenames

    COMPREPLY=( "${COMPREPLY[@]}" "${toks[@]}" )
}
