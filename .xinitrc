#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
