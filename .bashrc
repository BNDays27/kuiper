#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

fastfetch

source ~/.aliases
alias c="clear && source ~/.bashrc"

eval "$(zoxide init bash)"
source ~/.fzf
EDITOR=nvim
