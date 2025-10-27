# only uses the fastfetch image if the terminal is either kitty or tmux, if you don't have either of them and want to use it, add the $TERM value here
if [[ "$TERM" != "xterm-kitty" && "$TERM" != "tmux-256color" ]]; then
    fastfetch --config ~/.config/fastfetch/config-no-image.jsonc --logo small
else
    fastfetch
fi


# Created by newuser for 5.9

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# so fzf-tab works
autoload -Uz compinit
compinit -D


# custom plugins
# zinit ice depth=1; zinit light fdellwing/zsh-bat
zinit ice depth=1; zinit light zsh-users/zsh-history-substring-search
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light rylnd/shpec
zinit ice depth=1; zinit light chrissicool/zsh-256color
zinit ice depth=1; zinit light MichaelAquilina/zsh-you-should-use
zinit ice depth=1; zinit light Aloxaf/fzf-tab

### End of Zinit's installer chunk


### keybindings for ZSH
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey '^[[3~' delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey "^D" backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey '^f' autosuggest-accept

### ZSH aliases
source ~/.aliases
alias c="clear && source ~/.zshrc"

# Add in snippets

zinit snippet OMZP::sudo
zinit snippet OMZP::git
zinit snippet OMZP::archlinux
zinit snippet OMZP::tldr
zinit snippet "https://github.com/catppuccin/zsh-syntax-highlighting/blob/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"

# source ~/git/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

export MANPAGER="nvim +Man!"

# some history options for zsh
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'   
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color --all $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color --all $realpath'
zstyle ':completion:*' menu no

export PATH=/home/burhan/.local/bin:/home/burhan/.local/share/zinit/polaris/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl


eval "$(starship init zsh)"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_STATE_HOME="$HOME/.local/state"
eval "$(zoxide init --cmd cd zsh)"
source ~/.fzf
eval "$(fzf --zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
