#!/bin/bash
# this is a helper script which launches various commands

TERM=xterm

case `basename $0` in
    _hints)
        $TERM -e "hints.sh $@ && read"
        ;;
    *)
        exit 1
esac
