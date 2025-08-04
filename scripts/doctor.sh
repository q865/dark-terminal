#!/bin/bash
#
# doctor.sh - A script to diagnose the dark-terminal installation.
#

# --- Color Definitions ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Helper Functions ---
check_cmd() {
    local cmd="$1"
    local purpose="$2"
    printf "  %-20s" "$cmd"
    if command -v "$cmd" &> /dev/null; then
        printf "${GREEN}✔ Found${NC}\n"
        return 0
    else
        printf "${RED}✖ Not Found${NC} - $purpose\n"
        return 1
    fi
}

check_symlink() {
    local link_path="$1"
    local target_name="$2"
    printf "  %-20s" "$target_name"
    if [ -L "$link_path" ]; then
        if [[ $(readlink "$link_path") == *dark-terminal* ]]; then
            printf "${GREEN}✔ Correctly linked${NC}\n"
            return 0
        else
            printf "${RED}✖ Linked incorrectly${NC}\n"
            return 1
        fi
    else
        printf "${RED}✖ Not a symlink${NC}\n"
        return 1
    fi
}

echo "--- Running dark-terminal diagnosis ---"
echo 

# --- 1. Check Core Dependencies ---
echo "[1/3] Checking for essential commands..."
all_cmds_found=true
check_cmd "git" "Version control" || all_cmds_found=false
check_cmd "zsh" "The Z-shell" || all_cmds_found=false
check_cmd "tmux" "Terminal multiplexer" || all_cmds_found=false
check_cmd "nvim" "Neovim editor" || all_cmds_found=false
check_cmd "lf" "File manager" || all_cmds_found=false
check_cmd "fzf" "Fuzzy finder" || all_cmds_found=false
check_cmd "bat" "File previewer" || all_cmds_found=false
echo 

# --- 2. Check Configuration Symlinks ---
echo "[2/3] Checking configuration symlinks..."
all_links_ok=true
check_symlink "$HOME/.zshrc" ".zshrc" || all_links_ok=false
check_symlink "$HOME/.config/tmux" "tmux config" || all_links_ok=false
check_symlink "$HOME/.config/lf" "lf config" || all_links_ok=false
check_symlink "$HOME/.config/nvim" "nvim config" || all_links_ok=false

# Check for kitty only if not in headless mode
if [ ! -f "$HOME/.dark_terminal_headless" ]; then
    check_symlink "$HOME/.config/kitty" "kitty config" || all_links_ok=false
else
    printf "  %-20s ${YELLOW}Skipped (headless mode)${NC}\n" "kitty config"
fi
echo 

# --- 3. Check Environment ---
echo "[3/3] Checking environment..."
# Check for Oh My Zsh
printf "  %-20s"
if [ -d "$HOME/.oh-my-zsh" ]; then
    printf "${GREEN}✔ Found${NC}\n"
else
    printf "${RED}✖ Not Found${NC}\n"
fi

# Check for headless marker
printf "  %-20s"
if [ -f "$HOME/.dark_terminal_headless" ]; then
    printf "${YELLOW}Enabled${NC}\n"
else
    printf "${GREEN}Disabled${NC}\n"
fi
echo 

# --- Final Verdict ---
if [ "$all_cmds_found" = true ] && [ "$all_links_ok" = true ]; then
    echo -e "${GREEN}✔ Your dark-terminal installation looks healthy!${NC}"
else
    echo -e "${RED}✖ Diagnosis failed. Some components are missing or misconfigured.${NC}"
    echo "  Please consider running 'bash install.sh' again to fix the issues."
fi

exit 0
