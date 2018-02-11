#!/bin/sh

dev=/sys/class/backlight/radeon_bl0
curr_bg=`cat $dev/brightness`
max_bg=`cat $dev/max_brightness`

if [ $1 = "up" ];
then
	curr_bg=$((curr_bg+5))
	if [ "$curr_bg" -gt "$max_bg" ];
	then
		curr_bg=$max_bg
	fi
else
	curr_bg=$((curr_bg-5))
	if [ "$curr_bg" -lt 0 ];
	then
		curr_bg=0
	fi
fi

echo $curr_bg > $dev/brightness

