#!/bin/bash

choice=$(printf 'suspend\nreboot\npoweroff\n' |
          dmenu -i -m 0 -fn 'cherry:size=10' -nb '#101010' -nf '#bbbbbb' -sb '#252525' -sf '#eeeeee'
        )

loginctl "$choice"
