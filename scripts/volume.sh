#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
		awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master) | cut -d '%' -f 1
}

#function is_mute {
    #amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
#}

function send_notification {
    volume=`get_volume`
		#dunstify -i audio-volume-muted-blocking -t 8 -r 2593 -u normal "    $bar"
		notify-send -t 2500 -h string:x-dunst-stack-tag:volume -h int:value:$volume "Volume [$volume%]"

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	;;
esac
