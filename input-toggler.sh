#!/bin/sh

# inspired from https://askubuntu.com/questions/160945/is-there-a-way-to-disable-a-laptops-internal-keyboard

KEYBOARD="/devices/platform/i8042/serio0/input/input3"
TRACKPOINT="/devices/platform/i8042/serio1/serio2/input/input6"
TOUCHPAD="/devices/platform/i8042/serio1/input/input5"

ICON=/usr/local/lib/input-toggler/keyboard-on.png
ICOFF=/usr/local/lib/input-toggler/keyboard-off.png

NOTIFY_SEND=""

if [ x"$1" == 'xon' ] ; then
	USERS=$(loginctl --no-legend -l | awk '{print $3}' |sort |uniq)

	for USER in $USERS ; do
		systemd-run --machine=$USER@.host --user notify-send -i $ICON "Enabling keyboard and Trackpoint..." \ "ON - Keyboard connected!"
	done

	echo 0 > /sys/$KEYBOARD/inhibited
	echo 0 > /sys/$TRACKPOINT/inhibited
	echo 0 > /sys/$TOUCHPAD/inhibited
elif [ x"$1" == 'xoff' ] ; then
	USERS=$(loginctl --no-legend -l | awk '{print $3}' |sort |uniq)

	for USER in $USERS ; do
		systemd-run --machine=$USER@.host --user notify-send -i $ICOFF "Disabling keyboard and Trackpoint..." \ "OFF - Keyboard and Trackpoint disconnected!"
	done

	echo 1 > /sys/$KEYBOARD/inhibited
	echo 1 > /sys/$TRACKPOINT/inhibited
	echo 1 > /sys/$TOUCHPAD/inhibited
else
	if cat /sys/$KEYBOARD/inhibited | grep -q 1 ; then
        	$0 on
	else
        	$0 off
	fi
fi

