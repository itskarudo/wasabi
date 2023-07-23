#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
  pamixer --get-volume
}

function send_notification {
    volume=$(get_volume)
		notify-send -t 2500 -h string:x-dunst-stack-tag:volume -h int:value:"$volume" "Volume [$volume%]"

}

case $1 in
    up)
  pamixer -i 5
	send_notification
	;;
    down)
  pamixer -d 5
	send_notification
	;;
    mute)
    	# Toggle mute
      pamixer -t
	;;
esac
