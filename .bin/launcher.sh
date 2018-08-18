#!/bin/bash
# this is a helper script which launches various commands

TERM=i3-sensible-terminal

case `basename $0` in
    surf-priv)
        surf -d -a "a"
        ;;
    _hints)
        $TERM -e "hints.sh $@ && read"
        ;;
    _mc)
        $TERM -e mc
        ;;
    *)
        exit 1
esac
