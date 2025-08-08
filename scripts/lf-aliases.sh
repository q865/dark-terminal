#!/bin/bash

# Enhanced lf aliases for dark-terminal
# This file contains additional aliases and functions for lf integration

# =============================================================================
# LF ALIASES
# =============================================================================

# Quick lf navigation
alias lf='lf'
alias l='lf'
alias ll='lf -last-dir-path=/tmp/lf_last_dir'

# lf with specific directories
alias lfh='lf ~'
alias lfd='lf ~/Downloads'
alias lfp='lf ~/Pictures'
alias lfv='lf ~/Videos'
alias lfm='lf ~/Music'
alias lfD='lf ~/Documents'
alias lfc='lf ~/.config'
alias lfs='lf ~/dev_projects'

# lf with tmux integration
alias lft='tmux new-session -d -s lf && tmux send-keys -t lf "lf" Enter && tmux attach-session -t lf'
alias lfdev='tmux new-session -d -s dev && tmux send-keys -t dev "lf" Enter && tmux split-window -h && tmux send-keys -t dev:0.1 "nvim ." Enter && tmux attach-session -t dev'

# =============================================================================
# LF FUNCTIONS
# =============================================================================

# Function to open lf and cd to the selected directory
lfcd() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    fi
}

# Function to open lf in current directory and open selected file in Neovim
lfnvim() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -f "$dir" ]; then
            nvim "$dir"
        elif [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    fi
}

# Function to open lf and open selected file in default application
lfopen() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -f "$dir" ]; then
            if [ -n "$DISPLAY" ]; then
                xdg-open "$dir"
            else
                nvim "$dir"
            fi
        elif [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    fi
}

# Function to setup development environment with lf
lfdev_setup() {
    local project_dir="${1:-$(pwd)}"
    local project_name="$(basename "$project_dir")"
    
    # Create tmux session for development
    tmux new-session -d -s "dev-$project_name" -c "$project_dir"
    
    # Split window and setup panes
    tmux send-keys -t "dev-$project_name:0.0" "nvim ." Enter
    tmux split-window -h -t "dev-$project_name:0.0"
    tmux send-keys -t "dev-$project_name:0.1" "lf" Enter
    tmux split-window -v -t "dev-$project_name:0.1"
    tmux send-keys -t "dev-$project_name:0.2" "htop" Enter
    
    # Attach to session
    tmux attach-session -t "dev-$project_name"
}

# Function to open lf with git integration
lfgit() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            cd "$dir"
            if [ -d ".git" ]; then
                echo "Git repository detected"
                git status
            fi
        fi
    fi
}

# Function to open lf with project detection
lfproj() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            cd "$dir"
            
            # Detect project type
            if [ -f "package.json" ]; then
                echo "Node.js project detected"
                npm install
            elif [ -f "Cargo.toml" ]; then
                echo "Rust project detected"
                cargo check
            elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
                echo "Python project detected"
                pip install -r requirements.txt 2>/dev/null || echo "No requirements.txt found"
            elif [ -f "go.mod" ]; then
                echo "Go project detected"
                go mod tidy
            elif [ -f "pom.xml" ]; then
                echo "Maven project detected"
            elif [ -f "build.gradle" ]; then
                echo "Gradle project detected"
            fi
        fi
    fi
}

# =============================================================================
# LF INTEGRATION WITH TMUX
# =============================================================================

# Function to send file to tmux pane
lftmux() {
    local file="$1"
    local session="${2:-main}"
    local pane="${3:-0.1}"
    
    if [ -f "$file" ]; then
        tmux send-keys -t "$session:$pane" "nvim \"$file\"" Enter
    else
        echo "File not found: $file"
    fi
}

# Function to open lf in tmux pane
lftmuxlf() {
    local session="${1:-main}"
    local pane="${2:-0.1}"
    
    tmux send-keys -t "$session:$pane" "lf" Enter
}

# Function to setup tmux layout with lf
lftmuxlayout() {
    local session="${1:-main}"
    
    # Create new session if it doesn't exist
    if ! tmux has-session -t "$session" 2>/dev/null; then
        tmux new-session -d -s "$session"
    fi
    
    # Setup layout: Neovim on left, lf on right, terminal on bottom
    tmux send-keys -t "$session:0.0" "nvim ." Enter
    tmux split-window -h -t "$session:0.0"
    tmux send-keys -t "$session:0.1" "lf" Enter
    tmux split-window -v -t "$session:0.1"
    tmux send-keys -t "$session:0.2" "htop" Enter
    
    # Attach to session
    tmux attach-session -t "$session"
}

# =============================================================================
# LF FILE OPERATIONS
# =============================================================================

# Function to copy selected files
lfcp() {
    local files=("$@")
    if [ ${#files[@]} -ge 2 ]; then
        local dest="${files[-1]}"
        unset "files[-1]"
        cp "${files[@]}" "$dest"
        echo "Copied ${#files[@]} files to $dest"
    else
        echo "Usage: lfcp <file1> <file2> ... <destination>"
    fi
}

# Function to move selected files
lfmv() {
    local files=("$@")
    if [ ${#files[@]} -ge 2 ]; then
        local dest="${files[-1]}"
        unset "files[-1]"
        mv "${files[@]}" "$dest"
        echo "Moved ${#files[@]} files to $dest"
    else
        echo "Usage: lfmv <file1> <file2> ... <destination>"
    fi
}

# Function to create backup of file
lfbackup() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        echo "Created backup: $backup"
    else
        echo "File not found: $file"
    fi
}

# Function to compare files
lfdiff() {
    local file1="$1"
    local file2="$2"
    
    if [ -f "$file1" ] && [ -f "$file2" ]; then
        if command -v delta &> /dev/null; then
            diff "$file1" "$file2" | delta
        else
            diff "$file1" "$file2"
        fi
    else
        echo "Usage: lfdiff <file1> <file2>"
    fi
}

# =============================================================================
# LF SEARCH AND FILTER
# =============================================================================

# Function to search files in current directory
lfsearch() {
    local pattern="$1"
    if [ -n "$pattern" ]; then
        find . -name "*$pattern*" -type f | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
    else
        echo "Usage: lfsearch <pattern>"
    fi
}

# Function to search content in files
lfcontent() {
    local pattern="$1"
    if [ -n "$pattern" ]; then
        if command -v rg &> /dev/null; then
            rg "$pattern" | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {1}'
        else
            grep -r "$pattern" . | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {1}'
        fi
    else
        echo "Usage: lfcontent <pattern>"
    fi
}

# Function to filter files by extension
lfext() {
    local ext="$1"
    if [ -n "$ext" ]; then
        find . -name "*.$ext" -type f | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
    else
        echo "Usage: lfext <extension>"
    fi
}

# =============================================================================
# LF ARCHIVE OPERATIONS
# =============================================================================

# Function to create archive from selected files
lfarchive() {
    local files=("$@")
    if [ ${#files[@]} -ge 1 ]; then
        local archive_name="archive_$(date +%Y%m%d_%H%M%S).tar.gz"
        tar -czf "$archive_name" "${files[@]}"
        echo "Created archive: $archive_name"
    else
        echo "Usage: lfarchive <file1> <file2> ..."
    fi
}

# Function to extract archive
lfextract() {
    local archive="$1"
    local dest="${2:-.}"
    
    if [ -f "$archive" ]; then
        case "$archive" in
            *.tar.gz|*.tgz) tar -xzf "$archive" -C "$dest" ;;
            *.tar.bz2|*.tbz2) tar -xjf "$archive" -C "$dest" ;;
            *.tar.xz|*.txz) tar -xJf "$archive" -C "$dest" ;;
            *.zip) unzip "$archive" -d "$dest" ;;
            *.rar) unrar x "$archive" "$dest" ;;
            *.7z) 7z x "$archive" -o"$dest" ;;
            *) echo "Unsupported archive format" ;;
        esac
        echo "Extracted to: $dest"
    else
        echo "Archive not found: $archive"
    fi
}

# =============================================================================
# LF GIT OPERATIONS
# =============================================================================

# Function to show git status in lf
lfgitstatus() {
    if [ -d ".git" ]; then
        git status --porcelain | fzf --preview 'git diff {2}'
    else
        echo "Not a git repository"
    fi
}

# Function to add files to git from lf
lfgitadd() {
    local files=("$@")
    if [ ${#files[@]} -ge 1 ]; then
        git add "${files[@]}"
        echo "Added ${#files[@]} files to git"
    else
        echo "Usage: lfgitadd <file1> <file2> ..."
    fi
}

# Function to commit changes from lf
lfgitcommit() {
    local message="$1"
    if [ -n "$message" ]; then
        git commit -m "$message"
    else
        git commit
    fi
}

# =============================================================================
# LF SYSTEM INTEGRATION
# =============================================================================

# Function to open file with default application
lfopen() {
    local file="$1"
    if [ -f "$file" ]; then
        if [ -n "$DISPLAY" ]; then
            xdg-open "$file"
        else
            nvim "$file"
        fi
    else
        echo "File not found: $file"
    fi
}

# Function to show file information
lfinfo() {
    local file="$1"
    if [ -f "$file" ]; then
        echo "=== File Information ==="
        echo "Name: $(basename "$file")"
        echo "Size: $(du -h "$file" | cut -f1)"
        echo "Permissions: $(stat -c "%A" "$file")"
        echo "Type: $(file -b "$file")"
        echo "Modified: $(stat -c "%y" "$file")"
    else
        echo "File not found: $file"
    fi
}

# Function to create new file
lfnew() {
    local file="$1"
    if [ -n "$file" ]; then
        touch "$file"
        nvim "$file"
    else
        echo "Usage: lfnew <filename>"
    fi
}

# Function to create new directory
lfmkdir() {
    local dir="$1"
    if [ -n "$dir" ]; then
        mkdir -p "$dir"
        cd "$dir"
    else
        echo "Usage: lfmkdir <dirname>"
    fi
}

# =============================================================================
# FUNCTION AVAILABILITY
# =============================================================================

# Functions are now available in the current shell
# Available functions:
# - lfcd, lfnvim, lfopen, lfdev_setup, lfgit, lfproj
# - lftmux, lftmuxlf, lftmuxlayout
# - lfcp, lfmv, lfbackup, lfdiff
# - lfsearch, lfcontent, lfext
# - lfarchive, lfextract
# - lfgitstatus, lfgitadd, lfgitcommit
# - lfopen, lfinfo, lfnew, lfmkdir

echo "Enhanced lf aliases and functions loaded."
