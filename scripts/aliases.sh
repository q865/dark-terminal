#!/bin/bash
# This script contains all aliases and functions to be sourced by your shell.

# ------------------------------------------------------------------------------
# ENVIRONMENT & EDITOR
# ------------------------------------------------------------------------------
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.local/bin:$PATH"

# Define a smart 'open' command, adapting for headless environments
if [ -f "$HOME/.dark_terminal_headless" ]; then
  # On a server, 'open' uses only text-based tools
  export open='
  case "$f" in
    *.md|*.txt|*.conf|*.sh|*.json|*.log|*.yml|*.toml) nvim "$f" ;;
    *) less "$f" ;;
  esac
  '
else
  # On a desktop, 'open' can use GUI applications
  export open='
  case "$f" in
    *.mp4|*.mkv|*.webm) mpv "$f" ;;
    *.pdf) zathura "$f" ;;
    *.md|*.txt|*.conf|*.sh|*.json) nvim "$f" ;;
    *) xdg-open "$f" ;;
  esac
  '
fi

# ------------------------------------------------------------------------------
# GENERAL ALIASES
# (The rest of the file remains the same)
# ...
# ------------------------------------------------------------------------------
# (The existing content of aliases.sh from here on)
# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Listing files (using eza if available, otherwise ls)
if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -la --icons --group-directories-first'
else
    alias ls='ls --color=auto'
    alias ll='ls -alhF'
    alias la='ls -A'
fi

# Other
alias cat='bat --paging=never'
alias vim='nvim'
alias vi='nvim'
alias tm='tmux'
alias lg='lazygit'
alias pingg='ping 8.8.8.8'
alias myip='curl ifconfig.me'

# ------------------------------------------------------------------------------
# APPLICATION ALIASES
# ------------------------------------------------------------------------------
# Zellij
alias zl="zellij --layout dev-setup"
alias za="zellij attach"
alias zs="zellij list-sessions"
alias zk="zellij kill-all-sessions"

# Custom Scripts
alias promptgen="bash ~/.local/bin/prompter.sh"
alias soundcloud-dl="/home/panch/dev_projects/my_sound-cloud/.venv/bin/python /home/panch/dev_projects/my_sound-cloud/soundcloud_downloader.py"

# ------------------------------------------------------------------------------
# SYSTEM ALIASES
# ------------------------------------------------------------------------------
# Update system packages
if [ -f /etc/arch-release ]; then
    alias update='yay -Syu'
    alias cleanup='sudo pacman -Sc'
elif [ -f /etc/debian_version ]; then
    alias update='sudo apt-get update && sudo apt-get upgrade -y'
    alias cleanup='sudo apt-get autoremove -y && sudo apt-get clean'
fi

# ------------------------------------------------------------------------------
# GIT ALIASES
# ------------------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glg='git log --graph --oneline --decorate --all'

# ------------------------------------------------------------------------------
# FUNCTIONS & FZF BINDINGS
# ------------------------------------------------------------------------------
# lf - file manager wrapper to cd on exit
lf () {
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    fi
}

# fzf keybindings
# Get the directory of the currently running script
FZF_LAUNCHER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/fzf-launcher.sh"

# Use bat for fzf previews
if command -v bat &> /dev/null; then
  export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

# Custom keybindings for fzf
# We use this method to avoid conflicts with the default fzf setup
if [ -n "$ZSH_VERSION" ]; then
    # Zsh bindings
    bindkey '^f' fzf-file-widget
    bindkey '^p' fzf-cd-widget
elif [ -n "$BASH_VERSION" ]; then
    # Bash bindings
    bind -x '"\C-f": "$FZF_LAUNCHER_PATH files"'
    bind -x '"\C-p": "$FZF_LAUNCHER_PATH projects"'
fi

echo "dark-terminal aliases and functions loaded."
