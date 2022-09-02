#!/bin/sh

pgrep play

if [ $? -eq 1 ]
then
	play ~/Music/shawty.mp3 &
else
	killall play
fi
