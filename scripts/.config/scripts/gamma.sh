#!/bin/bash

pid=$(pidof gammastep)

if [ -n "$pid" ]; then
  kill -9 $pid
else
  gammastep -O 4000k & disown
fi
