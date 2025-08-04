#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions ---
info() {
    echo "[INFO] $1"
}

warn() {
    echo "[WARN] $1"
}

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# --- Main Script ---
info "Starting the dark-terminal setup..."

# 1. Detect Operating System
PKG_MANAGER=""
if [ -f /etc/arch-release ]; then
    info "Arch Linux detected."
    PKG_MANAGER="pacman"
elif [ -f /etc/debian_version ]; then
    info "Debian/Ubuntu based system detected."
    PKG_MANAGER="apt"
else
    error "Unsupported operating system. This script supports Arch and Debian-based systems."
fi

# 2. Install Dependencies
info "Installing dependencies..."
PACKAGES="kitty tmux neovim lf fzf ripgrep bat jq"

# Add ueberzugpp for Arch, as it's in AUR and might need a helper.
# For now, we'll assume it's handled manually or with a helper like yay.
# On Debian, it needs a different installation method (pip).
if [ "$PKG_MANAGER" == "pacman" ]; then
    sudo pacman -Syu --noconfirm --needed $PACKAGES ueberzugpp
elif [ "$PKG_MANAGER" == "apt" ]; then
    sudo apt-get update
    sudo apt-get install -y $PACKAGES
    # ueberzugpp installation via pip for Debian-based systems
    sudo apt-get install -y python3-pip
    pip3 install ueberzugpp
fi

info "All dependencies installed successfully."

# 3. Backup existing configs and create symlinks
CONFIG_SOURCE_DIR="$(pwd)/configs"
CONFIG_DEST_DIR="$HOME/.config"

# List of configs to link (excluding nvim)
CONFIG_FOLDERS=("kitty" "tmux" "lf")

info "Setting up configuration files..."
mkdir -p "$CONFIG_DEST_DIR"

for folder in "${CONFIG_FOLDERS[@]}"; do
    source_path="$CONFIG_SOURCE_DIR/$folder"
    dest_path="$CONFIG_DEST_DIR/$folder"

    if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
        backup_path="${dest_path}.bak_$(date +%F_%T)"
        warn "Existing config found at $dest_path. Backing it up to $backup_path"
        mv "$dest_path" "$backup_path"
    fi

    info "Linking $source_path to $dest_path"
    ln -s -T "$source_path" "$dest_path"
done

# 4. Setup AstroNvim
info "Setting up AstroNvim..."
NVIM_CONFIG_DIR="$CONFIG_DEST_DIR/nvim"
if [ -e "$NVIM_CONFIG_DIR" ]; then
    backup_path="${NVIM_CONFIG_DIR}.bak_$(date +%F_%T)"
    warn "Existing nvim config found. Backing it up to $backup_path"
    mv "$NVIM_CONFIG_DIR" "$backup_path"
fi

info "Cloning AstroNvim template repository..."
git clone --depth 1 https://github.com/AstroNvim/template "$NVIM_CONFIG_DIR"

info "Removing default user example from AstroNvim template..."
rm -rf "$NVIM_CONFIG_DIR/lua/user"

info "Linking custom user configuration for AstroNvim..."
ln -s "$CONFIG_SOURCE_DIR/nvim/lua/user" "$NVIM_CONFIG_DIR/lua/user"

info "AstroNvim setup complete. Run 'nvim' to start the installation of plugins."

# 5. Source aliases
info "Adding aliases to shell configuration..."
ALIASES_PATH="$(pwd)/scripts/aliases.sh"
SHELL_CONFIG=""

if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    warn "Could not detect Zsh or Bash. Please add 'source $ALIASES_PATH' to your shell's config file manually."
fi

if [ -n "$SHELL_CONFIG" ]; then
    if grep -q "$ALIASES_PATH" "$SHELL_CONFIG"; then
        warn "Aliases are already sourced in $SHELL_CONFIG."
    else
        info "Adding alias source to $SHELL_CONFIG"
        echo -e "\n# Load dark-terminal aliases\nsource '$ALIASES_PATH'" >> "$SHELL_CONFIG"
    fi
fi

info "dark-terminal setup is complete! Restart your terminal or run 'source $SHELL_CONFIG' to apply changes."

exit 0

