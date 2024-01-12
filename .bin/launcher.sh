#!/bin/bash
# this is a helper script which launches various commands

TERM=xterm

case `basename $0` in
    _mc)
        $TERM -e mc
        ;;
    _hints)
        hints.sh "$@"
        ;;
    _base64decode)
        echo "$@" | base64 -d -
        ;;
    _xclip)
        xclip -o | xclip -selection clipboard
        ;;
    *)
        exit 1
esac
