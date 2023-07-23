#!/bin/bash

theme_file=~/.current_theme

current_theme=$(<$theme_file)

dark_wps=(~/Pictures/Wallpapers/Dark/*)
light_wps=(~/Pictures/Wallpapers/Light/*)

dark_wp=${dark_wps[RANDOM % ${#dark_wps[@]}]}
light_wp=${light_wps[RANDOM % ${#light_wps[@]}]}

# dark_wp=~/Pictures/Wallpapers/Dark/1673160812170613.png
# light_wp=~/Pictures/Wallpapers/Light/2021-06-07-09-32-46-1560113443236.jpg

usage() {
  echo "./dark-switch.sh light/dark/switch"
}

switch_theme() {

  case $1 in
      dark)
      sed -i "s/Graphite-Light/Graphite-Dark/" ~/.xsettingsd
      sed -i "s/Tela-circle-black/Tela-circle-black-dark/" ~/.xsettingsd
      feh --bg-scale "$dark_wp"
      echo dark > $theme_file
    ;;
      light)
      sed -i "s/Graphite-Dark/Graphite-Light/" ~/.xsettingsd
      sed -i "s/Tela-circle-black-dark/Tela-circle-black/" ~/.xsettingsd
      feh --bg-scale "$light_wp"
      echo light > $theme_file
    ;;
      switch)
        if [ "$current_theme" == "dark" ]; then
          switch_theme light
        else
          switch_theme dark
        fi
    ;;
    *)
      usage
      exit 1
  esac

  killall -HUP xsettingsd

}

switch_theme "${@}"
