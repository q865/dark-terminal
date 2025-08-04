#!/bin/bash
#
# theme-switcher.sh - A script to change the color scheme across all applications.
# Usage: ./theme-switcher.sh [nord|catppuccin]
#

set -e

# --- Helper Functions ---
info() {
    echo "[INFO] $1"
}

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# Get the absolute path of the project's root directory
# This assumes the script is in a subdirectory of the root (e.g., scripts/)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="$ROOT_DIR/configs"

# --- Theme Definitions ---

# Function to apply the Nord theme
apply_nord() {
    info "Applying Nord theme..."

    # 1. Update kitty.conf
    sed -i -e "s/^# --- Theme .*/# --- Theme (Nord) ---/"
           -e "/# Polar Night/,/#3B4252/c\
# Polar Night\
color0  #2E3440\
color8  #4C566A\
\
# Snow Storm\
color7  #ECEFF4\
color15 #FFFFFF\
\
# Frost\
color1  #88C0D0\
color2  #8FBCBB\
color3  #81A1C1\
color4  #5E81AC\
\
# Aurora\
color5  #B48EAD\
color6  #A3BE8C\
color9  #D08770\
color10 #EBCB8B\
color11 #BF616A\
color12 #D8DEE9\
color13 #434C5E\
color14 #3B4252" "$CONFIG_DIR/kitty/kitty.conf"

    # 2. Update tmux.conf
    sed -i -e "s/^# --- Theme .*/# --- Theme (Nord) ---/"
           -e "s/set -g status-style 'bg=.* fg=.*'/set -g status-style 'bg=#3B4252 fg=#ECEFF4'/"
           -e "s/set -g status-left '#\[fg=.*,bg=.*\] #S/set -g status-left '#\[fg=#88C0D0,bg=#2E3440\] #S/"
           -e "s/setw -g window-status-current-style 'fg=.* bg=.*'/setw -g window-status-current-style 'fg=#2E3440 bg=#88C0D0'/"
           -e "s/set -g pane-active-border-style 'fg=.*'/set -g pane-active-border-style 'fg=#88C0D0'/"
           "$CONFIG_DIR/tmux/tmux.conf"

    # 3. Update AstroNvim (init.lua)
    sed -i "s/colorscheme = ".*"/colorscheme = \"nord\"/" "$CONFIG_DIR/nvim/lua/user/init.lua"
    # Ensure the nord plugin is there
    if ! grep -q "shaunsingh/nord.nvim" "$CONFIG_DIR/nvim/lua/user/init.lua"; then
        sed -i "/init = {/a\      { \"shaunsingh/nord.nvim\" }," "$CONFIG_DIR/nvim/lua/user/init.lua"
    fi
    # Remove catppuccin plugin if it exists
    sed -i "/\"catppuccin\/nvim\"/d" "$CONFIG_DIR/nvim/lua/user/init.lua"

    info "Nord theme applied successfully."
}

# Function to apply the Catppuccin theme
apply_catppuccin() {
    info "Applying Catppuccin (Mocha) theme..."

    # 1. Update kitty.conf
    sed -i -e "s/^# --- Theme .*/# --- Theme (Catppuccin) ---/"
           -e "/# Polar Night/,/#3B4252/c\
# Catppuccin Mocha\
color0  #1E1E2E \
color8  #45475A \
\
color7  #BAC2DE \
color15 #CDD6F4 \
\
color1  #F38BA8 \
color2  #A6E3A1 \
color3  #F9E2AF \
color4  #89B4FA \
\
color5  #F5C2E7 \
color6  #94E2D5 \
color9  #FAB387 \
color10 #F9E2AF \
color11 #F38BA8 \
color12 #CDD6F4 \
color13 #585B70 \
color14 #11111B" "$CONFIG_DIR/kitty/kitty.conf"

    # 2. Update tmux.conf
    sed -i -e "s/^# --- Theme .*/# --- Theme (Catppuccin) ---/"
           -e "s/set -g status-style 'bg=.* fg=.*'/set -g status-style 'bg=#181825 fg=#CDD6F4'/"
           -e "s/set -g status-left '#\[fg=.*,bg=.*\] #S/set -g status-left '#\[fg=#89B4FA,bg=#1E1E2E\] #S/"
           -e "s/setw -g window-status-current-style 'fg=.* bg=.*'/setw -g window-status-current-style 'fg=#11111B bg=#89B4FA'/"
           -e "s/set -g pane-active-border-style 'fg=.*'/set -g pane-active-border-style 'fg=#89B4FA'/"
           "$CONFIG_DIR/tmux/tmux.conf"

    # 3. Update AstroNvim (init.lua)
    sed -i "s/colorscheme = ".*"/colorscheme = \"catppuccin\"/" "$CONFIG_DIR/nvim/lua/user/init.lua"
    # Ensure the catppuccin plugin is there
    if ! grep -q "catppuccin/nvim" "$CONFIG_DIR/nvim/lua/user/init.lua"; then
        sed -i "/init = {/a\      { \"catppuccin/nvim\", name = \"catppuccin\" }," "$CONFIG_DIR/nvim/lua/user/init.lua"
    fi
    # Remove nord plugin if it exists
    sed -i "/\"shaunsingh\/nord.nvim\"/d" "$CONFIG_DIR/nvim/lua/user/init.lua"

    info "Catppuccin theme applied successfully."
}


# --- Main Logic ---
if [ -z "$1" ]; then
    error "Usage: $0 [nord|catppuccin]"
fi

case "$1" in
    nord)
        apply_nord
        ;;    catppuccin)
        apply_catppuccin
        ;;    *)
        error "Invalid theme. Available themes: nord, catppuccin"
        ;;esac

info "Theme changed. Please restart kitty and run 'tmux source-file ~/.config/tmux/tmux.conf' for changes to take full effect."
info "For Neovim, run :PackerSync after launching."
exit 0
