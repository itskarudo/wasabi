#!/bin/bash
# Tiny colored fetch script
# Requires Typicons Font to display the icons
# elenapan @ github

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done

d=$'\e[1m'
t=$'\e[0m'


cat << EOF
   (\ /)
   ( $d. .$t)
   c($f1"$t)($f1"$t)
EOF

