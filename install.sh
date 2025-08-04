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

# --- Dependency Installation ---
install_packages() {
    info "Installing base dependencies..."
    local packages="kitty tmux neovim lf fzf ripgrep bat jq zsh"
    if [ "$1" == "pacman" ]; then
        sudo pacman -Syu --noconfirm --needed $packages eza starship zoxide direnv fastfetch
    elif [ "$1" == "apt" ]; then
        sudo apt-get update
        sudo apt-get install -y $packages zoxide direnv
        # Install eza, starship, fastfetch manually for Debian/Ubuntu
        # (These commands might need adjustment based on current best practices)
        info "Installing eza, starship, fastfetch for Debian-based system..."
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt-get update
        sudo apt-get install -y eza
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
        # Assuming fastfetch is in recent Debian/Ubuntu repos, otherwise needs manual build/PPA
        sudo apt-get install -y fastfetch
    fi
    info "Base dependencies installed."
}

# --- Zsh & Oh My Zsh Setup ---
setup_zsh() {
    info "Setting up Zsh and Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        info "Oh My Zsh not found. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        info "Oh My Zsh is already installed."
    fi

    info "Installing Zsh plugins..."
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    # zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    fi
    # zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    fi
    info "Zsh plugins installed."
}

# --- Symlinking Function ---
link_config() {
    local source_path="$1"
    local dest_path="$2"
    
    if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
        backup_path="${dest_path}.bak_$(date +%F_%T)"
        warn "Existing config found at $dest_path. Backing it up to $backup_path"
        mv "$dest_path" "$backup_path"
    fi
    
    info "Linking $source_path to $dest_path"
    ln -s -T "$source_path" "$dest_path"
}

# --- Main Script ---
info "Starting the dark-terminal setup..."

# 1. Detect OS
PKG_MANAGER=""
if [ -f /etc/arch-release ]; then
    info "Arch Linux detected."
    PKG_MANAGER="pacman"
elif [ -f /etc/debian_version ]; then
    info "Debian/Ubuntu based system detected."
    PKG_MANAGER="apt"
else
    error "Unsupported OS. This script supports Arch and Debian-based systems."
fi

# 2. Install all dependencies
install_packages "$PKG_MANAGER"

# 3. Setup Zsh and plugins
setup_zsh

# 4. Backup existing configs and create symlinks
CONFIG_SOURCE_DIR="$(pwd)/configs"
CONFIG_DEST_DIR="$HOME/.config"
mkdir -p "$CONFIG_DEST_DIR"

# Link terminal/editor configs
link_config "$CONFIG_SOURCE_DIR/kitty" "$CONFIG_DEST_DIR/kitty"
link_config "$CONFIG_SOURCE_DIR/tmux" "$CONFIG_DEST_DIR/tmux"
link_config "$CONFIG_SOURCE_DIR/lf" "$CONFIG_DEST_DIR/lf"

# Link Zsh config
link_config "$CONFIG_SOURCE_DIR/zsh/zshrc" "$HOME/.zshrc"

# 5. Setup AstroNvim
info "Setting up AstroNvim..."
NVIM_CONFIG_DIR="$CONFIG_DEST_DIR/nvim"
if [ -d "$NVIM_CONFIG_DIR" ]; then
    warn "Existing nvim config found. Removing it for a clean install."
    rm -rf "$NVIM_CONFIG_DIR"
fi
info "Cloning AstroNvim template..."
git clone --depth 1 https://github.com/AstroNvim/template "$NVIM_CONFIG_DIR"
info "Removing default user example..."
rm -rf "$NVIM_CONFIG_DIR/lua/user"
info "Linking custom user configuration for AstroNvim..."
link_config "$CONFIG_SOURCE_DIR/nvim/lua/user" "$NVIM_CONFIG_DIR/lua/user"

# 6. Source aliases
info "Adding alias source to shell configuration..."
ALIASES_PATH="$(pwd)/scripts/aliases.sh"
ZSHRC_PATH="$HOME/.zshrc"

if grep -q "dark-terminal aliases" "$ZSHRC_PATH"; then
    warn "Aliases are already sourced in $ZSHRC_PATH."
else
    info "Adding alias source to $ZSHRC_PATH"
    echo -e "\n# Load dark-terminal aliases and functions\nsource '$ALIASES_PATH'" >> "$ZSHRC_PATH"
fi

# 7. Change default shell to Zsh
if [ "$SHELL" != "/bin/zsh" ]; then
    info "Changing default shell to Zsh. You may be asked for your password."
    chsh -s "$(which zsh)"
    info "Default shell changed to Zsh. Please log out and log back in for the change to take effect."
else
    info "Zsh is already the default shell."
fi

info "dark-terminal setup is complete!"
info "Please restart your terminal or log out and log back in to apply all changes."

exit 0