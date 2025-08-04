#!/bin/bash

# fzf-launcher.sh - A wrapper script to launch fzf for different purposes

# --- Configuration ---
# Define directories to search for projects. Add your own here.
# Default is ~/dev_projects, ~/dev, ~/projects, ~/work
PROJECT_DIRS="$HOME/dev_projects $HOME/dev $HOME/projects $HOME/work"

# --- Functions ---

# Find and open a file
find_files() {
    # Use fd if available, otherwise fallback to find
    local file
    local preview_cmd="if [ -f {} ]; then bat --color=always --style=numbers --line-range=:500 {}; fi"

    if command -v fd >/dev/null 2>&1; then
        file=$(fd --type f --hidden --exclude .git . | fzf-tmux -p 80%,60% -- --preview "$preview_cmd")
    else
        file=$(find . -type f -not -path '*/\.git/*' | fzf-tmux -p 80%,60% -- --preview "$preview_cmd")
    fi

    if [[ -n "$file" ]]; then
        # Open the file in the default editor
        $EDITOR "$file"
    fi
}

# Find and switch to a project directory, creating a tmux session if needed.
find_projects() {
    local existing_dirs=()
    for dir in $PROJECT_DIRS; do
        dir="${dir/#\~/$HOME}"
        if [ -d "$dir" ]; then
            existing_dirs+=("$dir")
        fi
    done

    if [ ${#existing_dirs[@]} -eq 0 ]; then
        echo "No project directories found in $PROJECT_DIRS. Please check the paths in fzf-launcher.sh" >&2
        sleep 2
        return
    fi

    local selected_dir
    selected_dir=$(find "${existing_dirs[@]}" -maxdepth 2 -type d -name ".git" 2>/dev/null | sed 's#/\.git##' | fzf-tmux -p 80%,60% --prompt="Switch to project: ")

    if [[ -n "$selected_dir" ]]; then
        local session_name=$(basename "$selected_dir" | tr '.-' '_')
        
        # Check if we are inside a tmux session
        if [ -n "$TMUX" ]; then
            # We are inside tmux
            if ! tmux has-session -t="$session_name" 2>/dev/null; then
                # Session doesn't exist, create it detached
                tmux new-session -d -s "$session_name" -c "$selected_dir"
            fi
            # Switch to the session
            tmux switch-client -t "$session_name"
        else
            # We are not inside tmux
            if ! tmux has-session -t="$session_name" 2>/dev/null; then
                # Session doesn't exist, create it and attach
                tmux new-session -s "$session_name" -c "$selected_dir"
            else
                # Session exists, attach to it
                tmux attach-session -t "$session_name"
            fi
        fi
    fi
}

# Find and execute a command from history
find_history() {
    local command
    command=$(history | fzf-tmux -p --tac | sed 's/ *[0-9]* *//')
    
    if [[ -n "$command" ]]; then
        # Print the command to the terminal so the user can execute it
        # This requires shell integration to work perfectly, but for now,
        # we can print it. A better way is to use shell bindings.
        echo "Executing: $command"
        eval "$command"
    fi
}


# --- Main Logic ---
case "$1" in
    files)
        find_files
        ;;
    projects)
        find_projects
        ;;
    history)
        find_history
        ;;
    *)
        echo "Usage: $0 {files|projects|history}"
        exit 1
        ;;
esac

exit 0
