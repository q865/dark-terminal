#!/bin/bash

# =============================================================================
# NEOVIM SETUP SCRIPT FOR DARK-TERMINAL
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install package based on system
install_package() {
    local package="$1"
    local description="$2"
    
    info "Installing $description..."
    
    if command_exists pacman; then
        # Arch Linux
        sudo pacman -S --noconfirm --needed "$package"
    elif command_exists apt; then
        # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install -y "$package"
    elif command_exists dnf; then
        # Fedora
        sudo dnf install -y "$package"
    elif command_exists brew; then
        # macOS
        brew install "$package"
    else
        warn "Unknown package manager. Please install $package manually."
        return 1
    fi
    
    success "$description installed successfully"
}

# Install Node.js if not present
install_nodejs() {
    if ! command_exists node; then
        info "Node.js not found. Installing..."
        
        if command_exists pacman; then
            install_package "nodejs npm" "Node.js and npm"
        elif command_exists apt; then
            # Add NodeSource repository for Ubuntu/Debian
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command_exists dnf; then
            install_package "nodejs npm" "Node.js and npm"
        elif command_exists brew; then
            brew install node
        else
            warn "Please install Node.js manually from https://nodejs.org/"
            return 1
        fi
    else
        success "Node.js already installed"
    fi
}

# Install Rust if not present
install_rust() {
    if ! command_exists cargo; then
        info "Rust not found. Installing..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        success "Rust installed successfully"
    else
        success "Rust already installed"
    fi
}

# Install Go if not present
install_go() {
    if ! command_exists go; then
        info "Go not found. Installing..."
        
        if command_exists pacman; then
            install_package "go" "Go programming language"
        elif command_exists apt; then
            install_package "golang-go" "Go programming language"
        elif command_exists dnf; then
            install_package "golang" "Go programming language"
        elif command_exists brew; then
            brew install go
        else
            warn "Please install Go manually from https://golang.org/"
            return 1
        fi
    else
        success "Go already installed"
    fi
}

# Install Python development tools
install_python_dev() {
    info "Installing Python development tools..."
    
    if command_exists pacman; then
        install_package "python-pip python-virtualenv" "Python development tools"
    elif command_exists apt; then
        install_package "python3-pip python3-venv" "Python development tools"
    elif command_exists dnf; then
        install_package "python3-pip python3-virtualenv" "Python development tools"
    elif command_exists brew; then
        brew install python
    fi
    
    # Install common Python packages
    pip3 install --user black flake8 mypy pylint
    success "Python development tools installed"
}

# Install C/C++ development tools
install_cpp_dev() {
    info "Installing C/C++ development tools..."
    
    if command_exists pacman; then
        install_package "gcc clang cmake make" "C/C++ development tools"
    elif command_exists apt; then
        install_package "build-essential clang cmake" "C/C++ development tools"
    elif command_exists dnf; then
        install_package "gcc clang cmake make" "C/C++ development tools"
    elif command_exists brew; then
        brew install gcc cmake
    fi
    
    success "C/C++ development tools installed"
}

# Install additional tools
install_additional_tools() {
    info "Installing additional development tools..."
    
    local tools=()
    
    if command_exists pacman; then
        tools=("git" "unzip" "ripgrep" "fd" "bat" "fzf" "tree" "htop" "neofetch")
    elif command_exists apt; then
        tools=("git" "unzip" "ripgrep" "fd-find" "bat" "fzf" "tree" "htop" "neofetch")
    elif command_exists dnf; then
        tools=("git" "unzip" "ripgrep" "fd-find" "bat" "fzf" "tree" "htop" "neofetch")
    elif command_exists brew; then
        tools=("git" "unzip" "ripgrep" "fd" "bat" "fzf" "tree" "htop" "neofetch")
    fi
    
    for tool in "${tools[@]}"; do
        if ! command_exists "$tool"; then
            install_package "$tool" "$tool"
        fi
    done
    
    success "Additional tools installed"
}

# Setup Neovim configuration
setup_nvim_config() {
    info "Setting up Neovim configuration..."
    
    # Create necessary directories
    mkdir -p ~/.cache/nvim/undo
    mkdir -p ~/.local/share/nvim/site/pack/packer/start
    
    # Ensure AstroNvim is properly installed
    if [ ! -d ~/.config/nvim ]; then
        error "AstroNvim not found. Please run the main install script first."
        return 1
    fi
    
    success "Neovim configuration setup complete"
}

# Install LSP servers
install_lsp_servers() {
    info "Installing LSP servers..."
    
    # Create a temporary Neovim session to install LSP servers
    cat > /tmp/install_lsp.lua << 'EOF'
-- Install LSP servers
local servers = {
  "bashls",
  "cssls", 
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "prettier",
  "tailwindcss",
  "tsserver",
  "vimls",
  "pyright",
  "rust_analyzer",
  "gopls",
  "clangd",
  "cmake",
  "dockerls",
  "terraformls",
  "yamlls",
  "eslint",
  "stylelint_ls",
  "sqls",
  "graphql",
  "prismals",
  "svelte",
  "volar",
  "astro",
  "emmet_ls",
  "unocss"
}

for _, server in ipairs(servers) do
  vim.cmd("LspInstall " .. server)
end

vim.cmd("q")
EOF

    nvim --headless -c "source /tmp/install_lsp.lua"
    rm /tmp/install_lsp.lua
    
    success "LSP servers installation initiated"
}

# Install TreeSitter parsers
install_treesitter() {
    info "Installing TreeSitter parsers..."
    
    # Create a temporary Neovim session to install TreeSitter parsers
    cat > /tmp/install_treesitter.lua << 'EOF'
-- Install TreeSitter parsers
local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "rust",
  "sql",
  "typescript",
  "yaml",
  "vue",
  "svelte",
  "astro",
  "prisma",
  "graphql",
  "dockerfile",
  "terraform",
  "toml",
  "ini",
  "xml",
  "scss",
  "less",
  "tsx",
  "jsx"
}

for _, parser in ipairs(parsers) do
  vim.cmd("TSInstall " .. parser)
end

vim.cmd("q")
EOF

    nvim --headless -c "source /tmp/install_treesitter.lua"
    rm /tmp/install_treesitter.lua
    
    success "TreeSitter parsers installation initiated"
}

# Install Mason tools
install_mason_tools() {
    info "Installing Mason tools..."
    
    # Create a temporary Neovim session to install Mason tools
    cat > /tmp/install_mason.lua << 'EOF'
-- Install Mason tools
local tools = {
  "bash-language-server",
  "css-lsp",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "marksman",
  "prettier",
  "tailwindcss-language-server",
  "typescript-language-server",
  "vim-language-server",
  "pyright",
  "rust-analyzer",
  "gopls",
  "clangd",
  "cmake-language-server",
  "docker-lsp",
  "terraform-ls",
  "yaml-language-server",
  "eslint-lsp",
  "stylelint-lsp",
  "sqls",
  "graphql-language-server",
  "prisma-language-server",
  "svelte-language-server",
  "vue-language-server",
  "astro-language-server",
  "emmet-ls",
  "unocss-language-server",
  "stylua",
  "black",
  "flake8",
  "mypy",
  "pylint",
  "rustfmt",
  "gofmt",
  "prettierd",
  "eslint_d",
  "stylelint",
  "shfmt",
  "shellcheck"
}

for _, tool in ipairs(tools) do
  vim.cmd("MasonInstall " .. tool)
end

vim.cmd("q")
EOF

    nvim --headless -c "source /tmp/install_mason.lua"
    rm /tmp/install_mason.lua
    
    success "Mason tools installation initiated"
}

# Setup Git configuration
setup_git() {
    info "Setting up Git configuration..."
    
    # Set default Git configuration if not already set
    if [ -z "$(git config --global user.name)" ]; then
        read -p "Enter your Git username: " git_username
        git config --global user.name "$git_username"
    fi
    
    if [ -z "$(git config --global user.email)" ]; then
        read -p "Enter your Git email: " git_email
        git config --global user.email "$git_email"
    fi
    
    # Set default branch name
    git config --global init.defaultBranch main
    
    # Set default editor
    git config --global core.editor nvim
    
    success "Git configuration complete"
}

# Main installation function
main() {
    info "Starting Neovim setup for dark-terminal..."
    
    # Check if Neovim is installed
    if ! command_exists nvim; then
        error "Neovim not found. Please install Neovim first."
        exit 1
    fi
    
    # Install system dependencies
    install_nodejs
    install_rust
    install_go
    install_python_dev
    install_cpp_dev
    install_additional_tools
    
    # Setup configurations
    setup_nvim_config
    setup_git
    
    # Install Neovim components
    install_lsp_servers
    install_treesitter
    install_mason_tools
    
    success "Neovim setup complete!"
    info "Please restart Neovim to load all changes."
    info "You can now use :ToggleLayout to switch between Russian and English layouts."
}

# Run main function
main "$@"
