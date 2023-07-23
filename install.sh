#!/bin/bash

if ! command -v stow &>/dev/null; then
  printf "\033[1;31mplease install GNU stow.\033[0m\n"
fi


to_link=(bash dunst fonts hyprland mpv neofetch nvim rofi scripts tmux wallpapers waybar wezterm zathura)

for cmd in "${to_link[@]}"; do
  stow -t ~/ "$cmd"
done
