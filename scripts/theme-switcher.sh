#!/bin/bash
#
# theme-switcher.sh - A script to change the color scheme across all applications.
# Usage: ./theme-switcher.sh [theme_name]
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

# --- Configuration ---
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="$ROOT_DIR/configs"
KITTY_CONFIG="$CONFIG_DIR/kitty/kitty.conf"
TMUX_CONFIG="$CONFIG_DIR/tmux/tmux.conf"
NVIM_CONFIG="$CONFIG_DIR/nvim/lua/user/init.lua"

# --- Theme Application Function ---
# This function handles the core logic of replacing colors and plugins.
apply_theme() {
    local theme_name="$1"
    local kitty_palette="$2"
    local tmux_palette="$3"
    local nvim_plugin="$4"
    local nvim_colorscheme="$5"

    info "Applying $theme_name theme..."

    # 1. Update kitty.conf if it exists
    if [ -f "$KITTY_CONFIG" ]; then
        sed -i "/# --- Theme/c\# --- Theme ($theme_name) ---" "$KITTY_CONFIG"
        sed -i "/# Polar Night/,/# Aurora/c\\$kitty_palette" "$KITTY_CONFIG"
    fi
    
    # 2. Update tmux.conf
    # We use @ as a sed delimiter because the replacement string contains slashes
    sed -i "/# --- Theme/c\# --- Theme ($theme_name) ---" "$TMUX_CONFIG"
    sed -i "s@set -g status-style .*@${tmux_palette[0]}@" "$TMUX_CONFIG"
    sed -i "s@set -g status-left .*@${tmux_palette[1]}@" "$TMUX_CONFIG"
    sed -i "s@setw -g window-status-current-style .*@${tmux_palette[2]}@" "$TMUX_CONFIG"
    sed -i "s@set -g pane-active-border-style .*@${tmux_palette[3]}@" "$TMUX_CONFIG"

    # 3. Update AstroNvim (init.lua)
    sed -i "s/colorscheme = \".*\"/colorscheme = \"$nvim_colorscheme\"/" "$NVIM_CONFIG"
    sed -i "/-- THEME_PLUGIN_START/,/-- THEME_PLUGIN_END/c\\-- THEME_PLUGIN_START\n      $nvim_plugin\n      -- THEME_PLUGIN_END" "$NVIM_CONFIG"

    info "$theme_name theme applied successfully."
}

# --- Main Logic ---
main() {
    if [ -z "$1" ]; then
        error "Usage: $0 [nord|catppuccin|dracula|tokyonight|gruvbox|everforest|rosepine]"
    fi

    local theme="$1"

    # --- Palettes and Plugins ---
    # Each theme has its own set of color palettes and nvim plugin definition.

    local kitty_nord='# Polar Night\ncolor0  #2E3440\ncolor8  #4C566A\n\n# Snow Storm\ncolor7  #ECEFF4\ncolor15 #FFFFFF\n\n# Frost\ncolor1  #88C0D0\ncolor2  #8FBCBB\ncolor3  #81A1C1\ncolor4  #5E81AC\n\n# Aurora'
    local tmux_nord=("set -g status-style 'bg=#3B4252 fg=#ECEFF4'" "set -g status-left '#[fg=#88C0D0,bg=#2E3440] #S #[fg=#ECEFF4,bg=#3B4252] | '" "setw -g window-status-current-style 'fg=#2E3440 bg=#88C0D0'" "set -g pane-active-border-style 'fg=#88C0D0'")
    local nvim_nord='{ "shaunsingh/nord.nvim" },'

    local kitty_catppuccin='# Polar Night\ncolor0  #1E1E2E\ncolor8  #45475A\n\n# Snow Storm\ncolor7  #BAC2DE\ncolor15 #CDD6F4\n\n# Frost\ncolor1  #F38BA8\ncolor2  #A6E3A1\ncolor3  #F9E2AF\ncolor4  #89B4FA\n\n# Aurora'
    local tmux_catppuccin=("set -g status-style 'bg=#181825 fg=#CDD6F4'" "set -g status-left '#[fg=#89B4FA,bg=#1E1E2E] #S #[fg=#CDD6F4,bg=#181825] | '" "setw -g window-status-current-style 'fg=#11111B bg=#89B4FA'" "set -g pane-active-border-style 'fg=#89B4FA'")
    local nvim_catppuccin='{ "catppuccin/nvim", name = "catppuccin" },'

    local kitty_dracula='# Polar Night\ncolor0  #282a36\ncolor8  #6272a4\n\n# Snow Storm\ncolor7  #f8f8f2\ncolor15 #ffffff\n\n# Frost\ncolor1  #ff5555\ncolor2  #50fa7b\ncolor3  #f1fa8c\ncolor4  #bd93f9\n\n# Aurora'
    local tmux_dracula=("set -g status-style 'bg=#282a36 fg=#f8f8f2'" "set -g status-left '#[fg=#50fa7b,bg=#44475a] #S #[fg=#f8f8f2,bg=#282a36] | '" "setw -g window-status-current-style 'fg=#282a36 bg=#bd93f9'" "set -g pane-active-border-style 'fg=#bd93f9'")
    local nvim_dracula='{ "Mofiqul/dracula.nvim" },'

    local kitty_tokyonight='# Polar Night\ncolor0  #1a1b26\ncolor8  #414868\n\n# Snow Storm\ncolor7  #c0caf5\ncolor15 #c0caf5\n\n# Frost\ncolor1  #f7768e\ncolor2  #9ece6a\ncolor3  #e0af68\ncolor4  #7aa2f7\n\n# Aurora'
    local tmux_tokyonight=("set -g status-style 'bg=#1a1b26 fg=#c0caf5'" "set -g status-left '#[fg=#9ece6a,bg=#24283b] #S #[fg=#c0caf5,bg=#1a1b26] | '" "setw -g window-status-current-style 'fg=#1a1b26 bg=#7aa2f7'" "set -g pane-active-border-style 'fg=#7aa2f7'")
    local nvim_tokyonight='{ "folke/tokyonight.nvim" },'

    local kitty_gruvbox='# Polar Night\ncolor0  #282828\ncolor8  #928374\n\n# Snow Storm\ncolor7  #ebdbb2\ncolor15 #ebdbb2\n\n# Frost\ncolor1  #cc241d\ncolor2  #98971a\ncolor3  #d79921\ncolor4  #458588\n\n# Aurora'
    local tmux_gruvbox=("set -g status-style 'bg=#282828 fg=#ebdbb2'" "set -g status-left '#[fg=#98971a,bg=#3c3836] #S #[fg=#ebdbb2,bg=#282828] | '" "setw -g window-status-current-style 'fg=#282828 bg=#fabd2f'" "set -g pane-active-border-style 'fg=#fabd2f'")
    local nvim_gruvbox='{ "ellisonleao/gruvbox.nvim" },'

    local kitty_everforest='# Polar Night\ncolor0  #2d353b\ncolor8  #4a555b\n\n# Snow Storm\ncolor7  #d3c6aa\ncolor15 #d3c6aa\n\n# Frost\ncolor1  #e67e80\ncolor2  #a7c080\ncolor3  #dbbc7f\ncolor4  #7fbbb3\n\n# Aurora'
    local tmux_everforest=("set -g status-style 'bg=#2d353b fg=#d3c6aa'" "set -g status-left '#[fg=#a7c080,bg=#3f4444] #S #[fg=#d3c6aa,bg=#2d353b] | '" "setw -g window-status-current-style 'fg=#2d353b bg=#a7c080'" "set -g pane-active-border-style 'fg=#a7c080'")
    local nvim_everforest='{ "sainnhe/everforest" },'

    local kitty_rosepine='# Polar Night\ncolor0  #191724\ncolor8  #555169\n\n# Snow Storm\ncolor7  #e0def4\ncolor15 #e0def4\n\n# Frost\ncolor1  #eb6f92\ncolor2  #9ccfd8\ncolor3  #f6c177\ncolor4  #31748f\n\n# Aurora'
    local tmux_rosepine=("set -g status-style 'bg=#191724 fg=#e0def4'" "set -g status-left '#[fg=#eb6f92,bg=#26233a] #S #[fg=#e0def4,bg=#191724] | '" "setw -g window-status-current-style 'fg=#191724 bg=#eb6f92'" "set -g pane-active-border-style 'fg=#eb6f92'")
    local nvim_rosepine='{ "rose-pine/neovim", name = "rose-pine" },'

    case "$theme" in
        nord)       apply_theme "Nord" "$kitty_nord" "${tmux_nord[*]}" "$nvim_nord" "nord" ;;
        catppuccin) apply_theme "Catppuccin" "$kitty_catppuccin" "${tmux_catppuccin[*]}" "$nvim_catppuccin" "catppuccin" ;;
        dracula)    apply_theme "Dracula" "$kitty_dracula" "${tmux_dracula[*]}" "$nvim_dracula" "dracula" ;;
        tokyonight) apply_theme "Tokyo Night" "$kitty_tokyonight" "${tmux_tokyonight[*]}" "$nvim_tokyonight" "tokyonight" ;;
        gruvbox)    apply_theme "Gruvbox" "$kitty_gruvbox" "${tmux_gruvbox[*]}" "$nvim_gruvbox" "gruvbox" ;;
        everforest) apply_theme "Everforest" "$kitty_everforest" "${tmux_everforest[*]}" "$nvim_everforest" "everforest" ;;
        rosepine)   apply_theme "Rosé Pine" "$kitty_rosepine" "${tmux_rosepine[*]}" "$nvim_rosepine" "rose-pine" ;;
        *) error "Invalid theme. Available themes: nord, catppuccin, dracula, tokyonight, gruvbox, everforest, rosepine" ;;
    esac

    info "Theme changed. Please restart kitty and run 'tmux source-file ~/.config/tmux/tmux.conf' for changes to take full effect."
    info "For Neovim, run :PackerSync or :Lazy sync after launching to install the new theme plugin if needed."
}

main "$@"
exit 0