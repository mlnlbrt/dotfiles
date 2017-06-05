#!/bin/bash
# this is a helper script which launches various commands

TERM=i3-sensible-terminal

case `basename $0` in
	s_ekg)
		$TERM -name EKG -title EKG -e bash -c "LANG=pl_PL luit ekg"
		;;
	s_mc)
		$TERM -name MC -title MC -e bash -c "mc"
		;;
	s_mcroot)
		gksudo -- $TERM -name MC -title MC -e bash -c "mc"
		;;
	*)
		exit 1
esac
