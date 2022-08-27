#
# ~/.bashrc
#

[[ $- != *i* ]] && return

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

export PATH="/home/karudo/.local/bin:/home/karudo/.yarn/bin:$PATH"

export PATH="/opt/cross/bin:$PATH"

alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -lha"
alias py="python"
alias ipy="ipython"

alias v="nvim"
alias t="tmux"

alias nf="neofetch"
alias pf="pfetch"
alias uwu="uwufetch"

alias pac="sudo pacman"
alias psr="pacman -Ss"
alias ysr="yay -Ss"
alias gic="git clone"

alias vconf="nvim ~/.config/nvim/init.lua"
alias bconf="nvim ~/.bashrc"
alias src="source ~/.bashrc"

alias esi_alger="proxychains ssh root@esi_alger"

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
PS1="${GREEN}\W${RESET} # "

export BFETCH_CLASSIC_MODE=true
export PF_INFO="ascii os kernel pkgs shell terminal wm uptime"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.cargo/env"

export DENO_INSTALL="/home/karudo/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"

eval "$(thefuck --alias)"

~/.config/scripts/bunny
