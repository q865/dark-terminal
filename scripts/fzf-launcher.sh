#!/bin/bash

# fzf-launcher.sh - A wrapper script to launch fzf for different purposes

# --- Configuration ---
# Define directories to search for projects. Add your own here.
# Default is ~/dev, ~/projects, ~/work
PROJECT_DIRS="$HOME/dev $HOME/projects $HOME/work"

# --- Functions ---

# Find and open a file
find_files() {
    # Use fd if available, otherwise fallback to find
    local file
    if command -v fd >/dev/null 2>&1; then
        file=$(fd --type f --hidden --exclude .git . '`' | fzf-tmux -p 80%,60% -- --preview 'bat --color=always --style=numbers {}')
    else
        file=$(find . -type f -not -path '*/\.git/*' | fzf-tmux -p 80%,60% -- --preview 'bat --color=always --style=numbers {}')
    fi

    if [[ -n "$file" ]]; then
        # Open the file in the default editor
        $EDITOR "$file"
    fi
}

# Find and switch to a project directory
find_projects() {
    local selected_dir
    # Scan project directories up to a depth of 2
    selected_dir=$(find $PROJECT_DIRS -maxdepth 2 -type d -name ".git" | sed 's#/\.git##' | fzf-tmux -p 80%,60%)

    if [[ -n "$selected_dir" ]]; then
        # If in tmux, create a new session or switch to an existing one
        local session_name=$(basename "$selected_dir" | tr . _)
        if tmux has-session -t=$session_name 2>/dev/null; then
            tmux switch-client -t $session_name
        else
            tmux new-session -d -s $session_name -c "$selected_dir"
            tmux switch-client -t $session_name
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
