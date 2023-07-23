#
# ~/.bashrc
#

[[ $- != *i* ]] && return

# [[ $(pgrep startx) = '' ]] && startx

export PATH="/home/karudo/.local/bin:/home/karudo/.yarn/bin:$PATH"

alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -lha"
# alias py="python"
alias py="ipython"
alias cat="bat"
alias cb="xclip -selection clipboard"
alias objdump="objdump -Mintel"
alias open="xdg-open"
alias woff="nmcli radio wifi off"
alias won="nmcli radio wifi on"

alias r="ranger"
alias v="nvim"
alias t="tmux"

alias nf="neofetch"
alias pf="pfetch"

alias pac="sudo pacman"
alias psr="pacman -Ss"
alias ysr="yay -Ss"
alias gic="git clone"
alias gs="git status"
alias gap="git add -p"

alias vconf="nvim ~/.config/nvim/init.lua"
alias bconf="nvim ~/.bashrc"
alias src="source ~/.bashrc"

# PS1="\[\e[0;32m\]\W\[\e(B\e[m\] # "
PS1="\W \$ "

export GOPATH="/home/karudo/.go"
export BAT_THEME=base16

~/.config/scripts/bunny.sh

export PATH=$PATH:/home/karudo/.spicetify
export PATH=$PATH:/home/karudo/.local/share/flutter/bin
export PATH=$PATH:/home/karudo/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:/home/karudo/.go/bin
export PATH=$PATH:/home/karudo/.depot_tools
