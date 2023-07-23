#!/bin/bash
TMP=/tmp/current_wall

wallpapers=(~/Pictures/Wallpapers/*)

index=$(<$TMP)
index=$((index+1))

if [ $index -ge ${#wallpapers[@]} ]; then
  index=0
fi
echo $index > $TMP
~/.config/scripts/wall.sh "${wallpapers[$index]}"
