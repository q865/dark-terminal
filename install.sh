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
main() {
    # Default to full installation
    local headless=false
    if [ "$1" == "--headless" ]; then
        headless=true
        info "Running in --headless mode. GUI components will be skipped."
    fi

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

    # 2. Install dependencies
    install_packages "$PKG_MANAGER" "$headless"

    # 3. Setup Zsh and plugins
    setup_zsh

    # 4. Backup existing configs and create symlinks
    info "Setting up configuration files..."
    CONFIG_SOURCE_DIR="$(pwd)/configs"
    CONFIG_DEST_DIR="$HOME/.config"
    mkdir -p "$CONFIG_DEST_DIR"

    # Link common configs
    link_config "$CONFIG_SOURCE_DIR/tmux" "$CONFIG_DEST_DIR/tmux"
    link_config "$CONFIG_SOURCE_DIR/lf" "$CONFIG_DEST_DIR/lf"
    link_config "$CONFIG_SOURCE_DIR/zsh/zshrc" "$HOME/.zshrc"

    # Link Kitty only if not in headless mode
    if [ "$headless" = false ]; then
        link_config "$CONFIG_SOURCE_DIR/kitty" "$CONFIG_DEST_DIR/kitty"
    fi

    # 5. Setup AstroNvim
    setup_astronvim "$CONFIG_SOURCE_DIR" "$CONFIG_DEST_DIR"

    # 6. Source aliases
    source_aliases "$HOME/.zshrc"

    # 7. Create headless mode marker file if needed
    if [ "$headless" = true ]; then
        touch "$HOME/.dark_terminal_headless"
        info "Created headless marker file at ~/.dark_terminal_headless"
    else
        rm -f "$HOME/.dark_terminal_headless"
    fi

    # 8. Change default shell to Zsh
    change_shell

    info "dark-terminal setup is complete!"
    info "Please restart your terminal or log out and log back in to apply all changes."
}

# --- Function Definitions ---

install_packages() {
    local pkg_manager="$1"
    local headless_mode="$2"
    info "Installing dependencies..."
    
    local base_packages="tmux neovim lf fzf ripgrep bat jq zsh"
    local desktop_packages="kitty"
    local extra_cli_tools="eza starship zoxide direnv fastfetch"

    if [ "$pkg_manager" == "pacman" ]; then
        local packages_to_install="$base_packages $extra_cli_tools"
        if [ "$headless_mode" = false ]; then
            packages_to_install="$packages_to_install $desktop_packages"
        fi
        sudo pacman -Syu --noconfirm --needed $packages_to_install
    elif [ "$pkg_manager" == "apt" ]; then
        # Debian/Ubuntu requires more manual steps for some tools
        sudo apt-get update
        sudo apt-get install -y $base_packages zoxide direnv
        
        if [ "$headless_mode" = false ]; then
            sudo apt-get install -y $desktop_packages
        fi
        
        info "Installing extra CLI tools for Debian-based system..."
        # eza
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        # starship
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
        # fastfetch
        sudo apt-get install -y fastfetch
    fi
    info "Dependencies installed."
}

setup_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        info "Oh My Zsh not found. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    info "Installing Zsh plugins..."
    local ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
}

link_config() {
    local source_path="$1"
    local dest_path="$2"
    if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
        local backup_path="${dest_path}.bak_$(date +%F_%T)"
        warn "Existing config at $dest_path. Backing up to $backup_path"
        mv "$dest_path" "$backup_path"
    fi
    info "Linking $source_path to $dest_path"
    ln -s -T "$source_path" "$dest_path"
}

setup_astronvim() {
    local config_source_dir="$1"
    local config_dest_dir="$2"
    info "Setting up AstroNvim..."
    local NVIM_CONFIG_DIR="$config_dest_dir/nvim"
    [ -d "$NVIM_CONFIG_DIR" ] && rm -rf "$NVIM_CONFIG_DIR"
    info "Cloning AstroNvim template..."
    git clone --depth 1 https://github.com/AstroNvim/template "$NVIM_CONFIG_DIR"
    rm -rf "$NVIM_CONFIG_DIR/lua/user"
    link_config "$config_source_dir/nvim/lua/user" "$NVIM_CONFIG_DIR/lua/user"
}

source_aliases() {
    local zshrc_path="$1"
    info "Adding alias source to shell configuration..."
    local ALIASES_PATH="$(pwd)/scripts/aliases.sh"
    if ! grep -q "dark-terminal aliases" "$zshrc_path"; then
        info "Adding alias source to $zshrc_path"
        echo -e "\n# Load dark-terminal aliases and functions\nsource '$ALIASES_PATH'" >> "$zshrc_path"
    fi
}

change_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        info "Changing default shell to Zsh. You may be asked for your password."
        chsh -s "$(which zsh)"
        info "Default shell changed. Please log out and log back in."
    fi
}

# --- Run the main function ---
main "$@"
exit 0
