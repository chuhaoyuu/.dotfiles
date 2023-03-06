# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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

# OMZ plugins
zi snippet OMZP::git
zi snippet OMZP::tmux

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit load agkozak/zsh-z
zinit load wfxr/forgit
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*' menu select

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

### End of Zinit's installer chunk

mkdir -p $ZSH_CACHE_DIR/completions
zi snippet OMZP::kubectl
source <(kubectl completion zsh)

# history
export HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=999999999
setopt share_history

# key binding
bindkey "^U" backward-kill-line

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
POWERLEVEL10K_MODE='nerdfont-fontconfig'
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# kubectl editor
export KUBE_EDITOR="/usr/local/bin/lvim"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias ls='lsd -l'
alias ll='lsd -l'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias vi='lvim'

export XDG_CONFIG_HOME=~/.config

# add .venv in current project
export PIPENV_VENV_IN_PROJECT=1
