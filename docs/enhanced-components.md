# Enhanced Components for dark-terminal

## Overview

This document describes the enhanced configurations for Kitty, zsh, and tmux in dark-terminal, providing a powerful and integrated development environment.

## 🎨 **Enhanced Kitty Configuration**

### **New Features**

#### **Enhanced Font Support**
- **Ligatures**: Full programming ligature support
- **Unicode Support**: Extended symbol mapping for better icon display
- **Font Fallbacks**: Robust fallback system for missing characters

#### **Advanced Window Management**
- **Rounded Corners**: Modern window border radius
- **Smart Padding**: Adaptive window padding
- **Window Margins**: Configurable margins for better spacing

#### **Enhanced Tab System**
- **Tab Navigation**: Quick tab switching with Ctrl+1-9
- **Tab Titles**: Custom tab title templates
- **Tab Bar**: Improved tab bar styling

#### **Performance Optimizations**
- **Increased Scrollback**: 10,000 lines of history
- **Better Rendering**: Optimized repaint and input delays
- **Shell Integration**: Enhanced shell integration features

#### **New Hotkeys**

| Key | Action |
|-----|--------|
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `Ctrl+1-9` | Go to specific tab |
| `Ctrl+Shift+Q` | Close window |
| `Ctrl+Shift+C/V` | Copy/Paste |
| `Ctrl+Equal/Minus` | Increase/Decrease font size |
| `Ctrl+0` | Reset font size |
| `Ctrl+L` | Clear terminal |
| `Ctrl+Shift+F` | Toggle fullscreen |
| `Ctrl+Shift+Arrow` | Move window |

#### **Mouse Support**
- **Focus Following**: Mouse focus following
- **Pointer Shapes**: Context-aware pointer shapes
- **Mouse Hiding**: Auto-hide mouse after 3 seconds

### **Configuration Files**
- **Main Config**: `~/.config/kitty/kitty.conf`
- **Theme Files**: `~/.config/kitty/kitty-themes/`

---

## 🐚 **Enhanced zsh Configuration**

### **New Features**

#### **Extended Plugin Support**
- **Development Tools**: Docker, Kubernetes, Node.js, Python, Rust, Go
- **Cloud Tools**: AWS, Terraform, Helm
- **System Tools**: Arch Linux, Debian support
- **Productivity**: Web search, JSON tools, URL tools

#### **Enhanced vi-mode**
- **Better Keybindings**: Improved vi-mode navigation
- **History Search**: Seamless history search in vi-mode
- **Quick Commands**: Enhanced command shortcuts

#### **Advanced History Management**
- **Large History**: 100,000 command history
- **Smart Deduplication**: Automatic duplicate removal
- **Extended History**: Timestamps and command duration
- **History Sharing**: Shared history across sessions

#### **Enhanced Completions**
- **Menu Selection**: Interactive completion menu
- **Case Insensitive**: Smart case matching
- **Color Coding**: Colored completion lists
- **Auto Rehash**: Automatic command rehashing

#### **New Aliases**

##### **Git Aliases**
```bash
g='git'
ga='git add'
gc='git commit -m'
gp='git push'
gco='git checkout'
gb='git branch'
gl='git log --oneline --graph --decorate'
gst='git status'
gd='git diff'
```

##### **Docker Aliases**
```bash
d='docker'
dc='docker-compose'
dps='docker ps'
dex='docker exec -it'
dlog='docker logs'
```

##### **Kubernetes Aliases**
```bash
k='kubectl'
kg='kubectl get'
kd='kubectl describe'
kl='kubectl logs'
kex='kubectl exec -it'
```

##### **Development Aliases**
```bash
n='npm'
y='yarn'
p='python'
c='cargo'
go='go'
```

##### **System Aliases**
```bash
update='sudo pacman -Syu'
install='sudo pacman -S'
search='sudo pacman -Ss'
orphans='sudo pacman -Rns $(pacman -Qtdq)'
```

#### **Custom Functions**

##### **File Operations**
```bash
mkcd()          # Create and navigate to directory
extract()       # Extract any archive format
backup()        # Create timestamped backup
findreplace()   # Find and replace in files
```

##### **System Functions**
```bash
pst()           # Show process tree
killp()         # Kill process by name
ds()            # Show directory size
topdirs()       # Show top directories by size
```

##### **Git Functions**
```bash
gitall()        # Show git status for all repos
gitupdate()     # Update all git repos
```

##### **Development Functions**
```bash
devsetup()      # Create development environment
```

### **Environment Variables**
- **Editor**: `nvim` as default editor
- **Language**: UTF-8 encoding
- **Paths**: Enhanced PATH with development tools
- **Development**: Go, Rust, Node.js paths

---

## 🎭 **Enhanced tmux Configuration**

### **New Features**

#### **Extended Plugin Support**
- **Session Management**: tmux-resurrect, tmux-continuum
- **Copy/Paste**: tmux-yank for clipboard integration
- **File Operations**: tmux-open, tmux-fpp
- **Search**: tmux-copycat, tmux-urlview
- **System Info**: tmux-battery, tmux-cpu
- **Logging**: tmux-logging for session logs

#### **Enhanced Window Management**
- **Window Numbers**: Quick window switching (0-9)
- **Window Titles**: Automatic window titling
- **Activity Monitoring**: Window activity tracking
- **Pane Zoom**: Toggle pane zoom with `z`

#### **Advanced Session Management**
- **Session Switching**: `Ctrl+s` for session tree
- **Session Creation**: Quick session creation
- **Session Persistence**: Auto-save/restore sessions

#### **Enhanced Copy Mode**
- **vi-mode**: Full vi-mode support in copy mode
- **Selection**: Visual selection and rectangle mode
- **Copy/Paste**: Enhanced copy/paste operations

#### **New Hotkeys**

##### **Window Management**
| Key | Action |
|-----|--------|
| `c` | New window |
| `w` | List windows |
| `n/p` | Next/Previous window |
| `0-9` | Go to window number |
| `x` | Kill pane |
| `X` | Kill window |
| `z` | Toggle pane zoom |

##### **Session Management**
| Key | Action |
|-----|--------|
| `S` | New session |
| `Ctrl+s` | Session tree |
| `s` | Choose session |

##### **Development Workflow**
| Key | Action |
|-----|--------|
| `D` | New dev window |
| `N` | New nvim window |
| `L` | New lf window |
| `T` | New test window |
| `g` | Git status window |
| `G` | Git log window |

##### **System Tools**
| Key | Action |
|-----|--------|
| `H` | htop window |
| `I` | System info window |
| `S` | System status window |

##### **File Operations**
| Key | Action |
|-----|--------|
| `f` | Open URLs in terminal |
| `F` | Open URLs in browser |

#### **Plugin Features**

##### **tmux-resurrect**
- **Save Sessions**: `prefix + S` to save
- **Restore Sessions**: `prefix + R` to restore
- **Auto-save**: Automatic session saving

##### **tmux-yank**
- **Copy Selection**: Copy to system clipboard
- **Mouse Copy**: Mouse-based copying
- **Primary/Clipboard**: Dual clipboard support

##### **tmux-continuum**
- **Auto-restore**: Automatic session restoration
- **Save Interval**: 15-second save intervals
- **Background Saving**: Continuous session saving

##### **tmux-copycat**
- **Search**: `prefix + Ctrl+f` for search
- **Git Search**: `prefix + Ctrl+g` for git search
- **Quick Navigation**: Fast search navigation

##### **tmux-logging**
- **Session Logs**: Automatic session logging
- **Timestamped**: Timestamped log files
- **Configurable**: Customizable log paths

### **Enhanced Status Bar**
- **Session Info**: Session name and user info
- **Time Display**: Current date and time
- **System Info**: User and host information
- **Update Interval**: 15-second updates

### **Performance Optimizations**
- **Zero Escape Time**: Instant command execution
- **Focus Events**: Enhanced focus handling
- **Color Support**: Full 256-color support

---

## 🔧 **Integration Features**

### **Cross-Component Integration**
- **Unified Theme**: Consistent Nord theme across all components
- **Shared Hotkeys**: Consistent keybindings
- **Path Integration**: Shared PATH and environment variables
- **Session Management**: Integrated session handling

### **Development Workflow**
- **Quick Setup**: One-command development environment
- **Tool Integration**: Seamless tool switching
- **Project Management**: Integrated project handling
- **Git Integration**: Enhanced git workflow

### **System Integration**
- **Package Management**: Integrated package management
- **System Monitoring**: Built-in system tools
- **Network Tools**: Network diagnostics and tools
- **File Management**: Enhanced file operations

---

## 🚀 **Usage Examples**

### **Development Workflow**
```bash
# Start development environment
tm

# Open project in Neovim
Ctrl+a N

# Open file manager
Ctrl+a L

# Run tests
Ctrl+a T

# Check git status
Ctrl+a g
```

### **System Management**
```bash
# Update system
update

# Install package
install package-name

# Check system status
Ctrl+a S

# Monitor system
Ctrl+a H
```

### **File Operations**
```bash
# Extract archive
extract archive.tar.gz

# Create backup
backup important-file.txt

# Find and replace
findreplace "*.txt" "old" "new"
```

---

## 📋 **Installation**

The enhanced configurations are automatically installed with dark-terminal:

1. **Kitty**: Enhanced terminal emulator configuration
2. **zsh**: Extended shell configuration with plugins
3. **tmux**: Advanced session management

### **Manual Installation**
```bash
# Clone repository
git clone https://github.com/q865/dark-terminal.git
cd dark-terminal

# Run installer
bash install.sh
```

---

## 🐛 **Troubleshooting**

### **Common Issues**

#### **Kitty Issues**
```bash
# Check configuration
kitty --config

# Test font rendering
kitty +kitten icat image.png

# Debug rendering
kitty --debug-gl
```

#### **zsh Issues**
```bash
# Reload configuration
source ~/.zshrc

# Check plugin installation
ls ~/.oh-my-zsh/plugins/

# Test completions
compinit
```

#### **tmux Issues**
```bash
# Reload configuration
prefix + r

# Check plugin installation
prefix + I

# Test session management
tmux list-sessions
```

### **Performance Issues**
- **Kitty**: Reduce `repaint_delay` and `input_delay`
- **zsh**: Disable unused plugins
- **tmux**: Reduce `status-interval`

---

## 📚 **Additional Resources**

### **Documentation**
- **Kitty**: https://sw.kovidgoyal.net/kitty/
- **zsh**: https://zsh.sourceforge.io/
- **tmux**: https://github.com/tmux/tmux/wiki

### **Plugins**
- **Oh My Zsh**: https://ohmyz.sh/
- **TPM**: https://github.com/tmux-plugins/tpm
- **Starship**: https://starship.rs/

### **Themes**
- **Nord**: https://www.nordtheme.com/
- **Kitty Themes**: https://github.com/dexpota/kitty-themes

---

## 🤝 **Contributing**

To contribute to the enhanced configurations:

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes**
4. **Test thoroughly**
5. **Submit a pull request**

### **Testing**
```bash
# Test Kitty configuration
kitty --config ~/.config/kitty/kitty.conf

# Test zsh configuration
zsh -c "source ~/.zshrc"

# Test tmux configuration
tmux source-file ~/.config/tmux/tmux.conf
```

---

## 📄 **License**

This enhanced configuration is part of the dark-terminal project and follows the same license terms.
