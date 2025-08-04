#!/bin/bash
#
# tmux-layout.sh - Creates a standard development layout in a new tmux window.
# Layout:
# - Left (70%): Neovim
# - Right (30%):
#   - Top: lf file manager
#   - Bottom: Shell prompt

# Create a new window named 'dev' and start nvim in the first pane
tmux new-window -n 'dev' 'nvim'

# Split the window horizontally, creating a new pane on the right (30% width)
tmux split-window -h -p 30

# Start lf in the new pane
tmux send-keys -t 2 'lf' C-m

# Split the right pane vertically, creating a new pane at the bottom (50% height)
tmux split-window -v -p 50

# Return focus to the main Neovim pane
tmux select-pane -t 1

# Make the script executable
# Note: This is a comment for context; the chmod command will be run separately.
