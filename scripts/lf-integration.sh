#!/bin/bash

# Enhanced lf integration script for dark-terminal
# This script provides seamless integration between lf, tmux, and Neovim

# =============================================================================
# CONFIGURATION
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LF_CONFIG_DIR="$HOME/.config/lf"
TMUX_SESSION="main"

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

# Function to check if tmux is running
is_tmux_running() {
    tmux info &> /dev/null
}

# Function to check if we're in a tmux session
in_tmux_session() {
    [ -n "$TMUX" ]
}

# Function to get current tmux session name
get_tmux_session() {
    if in_tmux_session; then
        tmux display-message -p '#S'
    else
        echo "$TMUX_SESSION"
    fi
}

# Function to send command to tmux pane
send_to_tmux() {
    local session="$1"
    local pane="$2"
    local command="$3"
    
    if is_tmux_running; then
        tmux send-keys -t "$session:$pane" "$command" Enter
    else
        echo "Tmux is not running"
    fi
}

# Function to create new tmux window
create_tmux_window() {
    local session="$1"
    local name="$2"
    local command="$3"
    
    if is_tmux_running; then
        tmux new-window -t "$session" -n "$name" "$command"
    else
        echo "Tmux is not running"
    fi
}

# =============================================================================
# LF INTEGRATION FUNCTIONS
# =============================================================================

# Function to open file in Neovim in current tmux pane
lf_open_in_nvim() {
    local file="$1"
    local session=$(get_tmux_session)
    
    if in_tmux_session; then
        # We're in tmux, send to current pane
        send_to_tmux "$session" "0.1" "nvim \"$file\""
    else
        # Not in tmux, open directly
        nvim "$file"
    fi
}

# Function to open file in Neovim in new tmux window
lf_open_in_nvim_new_window() {
    local file="$1"
    local session=$(get_tmux_session)
    local filename=$(basename "$file")
    
    create_tmux_window "$session" "$filename" "nvim \"$file\""
}

# Function to open file in Neovim in vertical split
lf_open_in_nvim_vsplit() {
    local file="$1"
    local session=$(get_tmux_session)
    
    if in_tmux_session; then
        send_to_tmux "$session" "0.1" "nvim -O \"$file\""
    else
        nvim -O "$file"
    fi
}

# Function to open file in Neovim in horizontal split
lf_open_in_nvim_hsplit() {
    local file="$1"
    local session=$(get_tmux_session)
    
    if in_tmux_session; then
        send_to_tmux "$session" "0.1" "nvim -o \"$file\""
    else
        nvim -o "$file"
    fi
}

# Function to open file in Neovim with specific line number
lf_open_in_nvim_line() {
    local file="$1"
    local line="$2"
    local session=$(get_tmux_session)
    
    if in_tmux_session; then
        send_to_tmux "$session" "0.1" "nvim +$line \"$file\""
    else
        nvim +$line "$file"
    fi
}

# =============================================================================
# DEVELOPMENT WORKFLOW FUNCTIONS
# =============================================================================

# Function to setup development environment
lf_setup_dev_env() {
    local project_dir="$1"
    local session=$(get_tmux_session)
    
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi
    
    if is_tmux_running; then
        # Create new session for development
        tmux new-session -d -s "dev-$(basename "$project_dir")" -c "$project_dir"
        tmux send-keys -t "dev-$(basename "$project_dir"):0.0" "nvim ." Enter
        tmux split-window -h -t "dev-$(basename "$project_dir"):0.0"
        tmux send-keys -t "dev-$(basename "$project_dir"):0.1" "lf" Enter
        tmux attach-session -t "dev-$(basename "$project_dir")"
    else
        # Start tmux with development setup
        tmux new-session -d -s "dev-$(basename "$project_dir")" -c "$project_dir"
        tmux send-keys -t "dev-$(basename "$project_dir"):0.0" "nvim ." Enter
        tmux split-window -h -t "dev-$(basename "$project_dir"):0.0"
        tmux send-keys -t "dev-$(basename "$project_dir"):0.1" "lf" Enter
        tmux attach-session -t "dev-$(basename "$project_dir")"
    fi
}

# Function to run tests
lf_run_tests() {
    local project_dir="$1"
    local session=$(get_tmux_session)
    
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi
    
    # Detect project type and run appropriate tests
    if [ -f "$project_dir/package.json" ]; then
        # Node.js project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && npm test"
    elif [ -f "$project_dir/Cargo.toml" ]; then
        # Rust project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && cargo test"
    elif [ -f "$project_dir/pyproject.toml" ] || [ -f "$project_dir/requirements.txt" ]; then
        # Python project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && python -m pytest"
    elif [ -f "$project_dir/go.mod" ]; then
        # Go project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && go test ./..."
    else
        echo "Unknown project type"
    fi
}

# Function to build project
lf_build_project() {
    local project_dir="$1"
    local session=$(get_tmux_session)
    
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi
    
    # Detect project type and run appropriate build command
    if [ -f "$project_dir/package.json" ]; then
        # Node.js project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && npm run build"
    elif [ -f "$project_dir/Cargo.toml" ]; then
        # Rust project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && cargo build"
    elif [ -f "$project_dir/pyproject.toml" ]; then
        # Python project with pyproject.toml
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && python -m build"
    elif [ -f "$project_dir/go.mod" ]; then
        # Go project
        send_to_tmux "$session" "0.2" "cd \"$project_dir\" && go build"
    else
        echo "Unknown project type"
    fi
}

# =============================================================================
# GIT INTEGRATION FUNCTIONS
# =============================================================================

# Function to show git status
lf_git_status() {
    local session=$(get_tmux_session)
    send_to_tmux "$session" "0.2" "git status"
}

# Function to add file to git
lf_git_add() {
    local file="$1"
    local session=$(get_tmux_session)
    send_to_tmux "$session" "0.2" "git add \"$file\""
}

# Function to commit changes
lf_git_commit() {
    local message="$1"
    local session=$(get_tmux_session)
    
    if [ -z "$message" ]; then
        message="Update $(date +%Y-%m-%d_%H:%M:%S)"
    fi
    
    send_to_tmux "$session" "0.2" "git commit -m \"$message\""
}

# Function to push changes
lf_git_push() {
    local session=$(get_tmux_session)
    send_to_tmux "$session" "0.2" "git push"
}

# Function to show git log
lf_git_log() {
    local session=$(get_tmux_session)
    send_to_tmux "$session" "0.2" "git log --oneline"
}

# =============================================================================
# FILE OPERATIONS
# =============================================================================

# Function to copy file
lf_copy_file() {
    local source="$1"
    local destination="$2"
    
    if [ -n "$source" ] && [ -n "$destination" ]; then
        cp "$source" "$destination"
        echo "Copied $source to $destination"
    else
        echo "Usage: lf_copy_file <source> <destination>"
    fi
}

# Function to move file
lf_move_file() {
    local source="$1"
    local destination="$2"
    
    if [ -n "$source" ] && [ -n "$destination" ]; then
        mv "$source" "$destination"
        echo "Moved $source to $destination"
    else
        echo "Usage: lf_move_file <source> <destination>"
    fi
}

# Function to create archive
lf_create_archive() {
    local source="$1"
    local archive_name="$2"
    
    if [ -z "$archive_name" ]; then
        archive_name="$(basename "$source")_$(date +%Y%m%d_%H%M%S).tar.gz"
    fi
    
    tar -czf "$archive_name" "$source"
    echo "Created archive: $archive_name"
}

# Function to extract archive
lf_extract_archive() {
    local archive="$1"
    local destination="$2"
    
    if [ -z "$destination" ]; then
        destination="."
    fi
    
    case "$archive" in
        *.tar.gz|*.tgz) tar -xzf "$archive" -C "$destination" ;;
        *.tar.bz2|*.tbz2) tar -xjf "$archive" -C "$destination" ;;
        *.tar.xz|*.txz) tar -xJf "$archive" -C "$destination" ;;
        *.zip) unzip "$archive" -d "$destination" ;;
        *.rar) unrar x "$archive" "$destination" ;;
        *.7z) 7z x "$archive" -o"$destination" ;;
        *) echo "Unsupported archive format" ;;
    esac
}

# =============================================================================
# MAIN FUNCTION
# =============================================================================

# Main function to handle different commands
main() {
    local command="$1"
    shift
    
    case "$command" in
        "nvim")
            lf_open_in_nvim "$1"
            ;;
        "nvim-new")
            lf_open_in_nvim_new_window "$1"
            ;;
        "nvim-vsplit")
            lf_open_in_nvim_vsplit "$1"
            ;;
        "nvim-hsplit")
            lf_open_in_nvim_hsplit "$1"
            ;;
        "nvim-line")
            lf_open_in_nvim_line "$1" "$2"
            ;;
        "dev-setup")
            lf_setup_dev_env "$1"
            ;;
        "run-tests")
            lf_run_tests "$1"
            ;;
        "build")
            lf_build_project "$1"
            ;;
        "git-status")
            lf_git_status
            ;;
        "git-add")
            lf_git_add "$1"
            ;;
        "git-commit")
            lf_git_commit "$1"
            ;;
        "git-push")
            lf_git_push
            ;;
        "git-log")
            lf_git_log
            ;;
        "copy")
            lf_copy_file "$1" "$2"
            ;;
        "move")
            lf_move_file "$1" "$2"
            ;;
        "archive")
            lf_create_archive "$1" "$2"
            ;;
        "extract")
            lf_extract_archive "$1" "$2"
            ;;
        *)
            echo "Usage: $0 <command> [args...]"
            echo "Commands:"
            echo "  nvim <file>                    - Open file in Neovim"
            echo "  nvim-new <file>                - Open file in new tmux window"
            echo "  nvim-vsplit <file>             - Open file in vertical split"
            echo "  nvim-hsplit <file>             - Open file in horizontal split"
            echo "  nvim-line <file> <line>        - Open file at specific line"
            echo "  dev-setup [dir]                - Setup development environment"
            echo "  run-tests [dir]                - Run project tests"
            echo "  build [dir]                    - Build project"
            echo "  git-status                     - Show git status"
            echo "  git-add <file>                 - Add file to git"
            echo "  git-commit [message]           - Commit changes"
            echo "  git-push                       - Push changes"
            echo "  git-log                        - Show git log"
            echo "  copy <source> <dest>           - Copy file"
            echo "  move <source> <dest>           - Move file"
            echo "  archive <source> [name]        - Create archive"
            echo "  extract <archive> [dest]       - Extract archive"
            ;;
    esac
}

# Run main function with all arguments
main "$@"
