#!/bin/bash
# This script contains aliases and functions to be sourced by your shell (.bashrc, .zshrc)

export EDITOR='nvim'

# --- Navigation ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# --- Listing files ---
# Always use colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Long format, human-readable sizes, all files
alias ll='ls -alhF'
# List all files
alias la='ls -A'
# List only files
alias l='ls -CF'

# --- Application Aliases ---
alias v='nvim'
alias vim='nvim'
alias tm='tmux'
alias l='lf'

# --- System ---
# Update system packages
if [ -f /etc/arch-release ]; then
    alias update='sudo pacman -Syu'
elif [ -f /etc/debian_version ]; then
    alias update='sudo apt-get update && sudo apt-get upgrade -y'
fi

# Cleanup (e.g., pacman cache or apt autoremove)
if [ -f /etc/arch-release ]; then
    alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
elif [ -f /etc/debian_version ]; then
    alias cleanup='sudo apt-get autoremove -y && sudo apt-get clean'
fi

# --- Git Aliases ---
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit -am'
alias gs='git status'
alias gp='git push'
alias gpull='git pull'
alias gl='git log --oneline --graph --decorate'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'

# --- Other ---
alias pingg='ping 8.8.8.8' # Ping Google
alias myip='curl ifconfig.me'

# --- fzf keybindings ---
# Get the directory of the currently running script
FZF_LAUNCHER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/fzf-launcher.sh"

if [ -n "$ZSH_VERSION" ]; then
    # Zsh bindings
    bindkey -s '^f' "source $FZF_LAUNCHER_PATH files\n"
    bindkey -s '^p' "source $FZF_LAUNCHER_PATH projects\n"
    # Ctrl+r is usually reverse-history-search, fzf overrides this by default
    # If fzf is installed with shell integration, this is often handled automatically.
    # We can add it manually if needed.
elif [ -n "$BASH_VERSION" ]; then
    # Bash bindings
    bind -x '"\C-f": "source $FZF_LAUNCHER_PATH files"'
    bind -x '"\C-p": "source $FZF_LAUNCHER_PATH projects"'
fi


echo "dark-terminal aliases loaded."

