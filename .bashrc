#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#eval "$(starship init bash)"
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.toml)"

# only uses the fastfetch image if the terminal is either kitty or tmux, if you don't have either of them and want to use it, add the $TERM value here
if [[ "$TERM" != "xterm-kitty" && "$TERM" != "tmux-256color" ]]; then
    fastfetch --config ~/.config/fastfetch/config-no-image.jsonc --logo small
else
    fastfetch
fi

source ~/.aliases
alias c="clear && source ~/.bashrc"

eval "$(zoxide init bash)"
source ~/.fzf
EDITOR=nvim
