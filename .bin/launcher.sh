#!/bin/bash
# this is a helper script which launches various commands

TERM=i3-sensible-terminal

case `basename $0` in
    surf-priv)
        surf -d -a "a"
        ;;
    *)
        exit 1
esac
