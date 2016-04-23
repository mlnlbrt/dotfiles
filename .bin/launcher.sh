#!/bin/bash
# this is a helper script which launches various commands

TERM=i3-sensible-terminal

case `basename $0` in
	s_ekg)
		$TERM -name EKG -title EKG -e bash -c "LANG=pl_PL luit ekg"
		;;
	s_mutt)
		$TERM -name MUTT -title MUTT -e bash -c "mutt"
		;;
	s_vimb)
		firejail vimb
		;;
	s_ncmpcpp)
		$TERM -name NCMPCPP -title NCMPCPP -e bash -c "ncmpcpp"
		;;
	s_mc)
		$TERM -name MC -title MC -e bash -c "mc"
		;;
	s_mcroot)
		gksudo -- $TERM -name MC -title MC -e bash -c "mc"
		;;
	s_nmrestart)
		gksudo -- systemctl restart NetworkManager
		;;
	s_3gon)
		nmcli r wwan on
		;;
	s_3goff)
		nmcli r wwan off
		;;
	s_3gfix)
		nmcli r wwan off; sleep 2; nmcli r wwan on; sleep 2; gksudo -- systemctl restart NetworkManager
		;;
	s_wifion)
		nmcli r wifi on
		;;
	s_wifioff)
		nmcli r wifi off
		;;
	*)
		exit 1
esac
