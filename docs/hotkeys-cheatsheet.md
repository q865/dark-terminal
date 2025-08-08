# Hotkeys Cheatsheet for dark-terminal

## 🎨 **Kitty Hotkeys**

### **Tab Management**
| Key | Action |
|-----|--------|
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `Ctrl+1-9` | Go to specific tab |
| `Ctrl+Shift+Enter` | New tab |
| `Ctrl+Shift+W` | Close tab |

### **Window Management**
| Key | Action |
|-----|--------|
| `Ctrl+Shift+T` | New window |
| `Ctrl+Shift+Q` | Close window |
| `Ctrl+Shift+F` | Toggle fullscreen |
| `Ctrl+Shift+Arrow` | Move window |

### **Font & Display**
| Key | Action |
|-----|--------|
| `Ctrl+Equal` | Increase font size |
| `Ctrl+Minus` | Decrease font size |
| `Ctrl+0` | Reset font size |
| `Ctrl+L` | Clear terminal |

### **Copy/Paste**
| Key | Action |
|-----|--------|
| `Ctrl+C` | Copy to clipboard |
| `Ctrl+V` | Paste from clipboard |
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |

---

## 🐚 **zsh Hotkeys**

### **Vi-mode Navigation**
| Key | Action |
|-----|--------|
| `Esc` | Enter normal mode |
| `i` | Enter insert mode |
| `v` | Enter visual mode |
| `h/j/k/l` | Navigate |
| `w/b` | Word navigation |
| `0/$` | Line navigation |
| `gg/G` | File navigation |

### **History Search**
| Key | Action |
|-----|--------|
| `Ctrl+R` | Search history |
| `Ctrl+S` | Forward search |
| `j/k` | Navigate history (in vi-mode) |

### **Completion**
| Key | Action |
|-----|--------|
| `Tab` | Complete |
| `Ctrl+Space` | Menu completion |
| `Ctrl+N/P` | Next/Previous |

### **Line Editing**
| Key | Action |
|-----|--------|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line |
| `Ctrl+K` | Kill line |
| `Ctrl+U` | Kill line backward |
| `Ctrl+W` | Kill word backward |
| `Ctrl+Y` | Yank |

---

## 🎭 **tmux Hotkeys**

### **Prefix Key**
- **Prefix**: `Ctrl+a`

### **Session Management**
| Key | Action |
|-----|--------|
| `prefix + S` | New session |
| `prefix + s` | Choose session |
| `prefix + C-s` | Session tree |
| `prefix + $` | Rename session |
| `prefix + d` | Detach session |

### **Window Management**
| Key | Action |
|-----|--------|
| `prefix + c` | New window |
| `prefix + w` | List windows |
| `prefix + n/p` | Next/Previous window |
| `prefix + 0-9` | Go to window |
| `prefix + ,` | Rename window |
| `prefix + &` | Kill window |

### **Pane Management**
| Key | Action |
|-----|--------|
| `prefix + |` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + x` | Kill pane |
| `prefix + z` | Toggle pane zoom |
| `prefix + o` | Next pane |
| `prefix + ;` | Previous pane |

### **Pane Navigation**
| Key | Action |
|-----|--------|
| `Alt+h/j/k/l` | Navigate panes |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + H/J/K/L` | Resize panes |

### **Copy Mode**
| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection |
| `q` | Quit copy mode |

### **Development Workflow**
| Key | Action |
|-----|--------|
| `prefix + D` | New dev window |
| `prefix + N` | New nvim window |
| `prefix + L` | New lf window |
| `prefix + T` | New test window |
| `prefix + g` | Git status window |
| `prefix + G` | Git log window |

### **System Tools**
| Key | Action |
|-----|--------|
| `prefix + H` | htop window |
| `prefix + I` | System info window |
| `prefix + S` | System status window |

### **File Operations**
| Key | Action |
|-----|--------|
| `prefix + f` | Open URLs in terminal |
| `prefix + F` | Open URLs in browser |

### **Plugin Hotkeys**
| Key | Action |
|-----|--------|
| `prefix + S` | Save session (resurrect) |
| `prefix + R` | Restore session (resurrect) |
| `prefix + y` | Copy to clipboard (yank) |
| `prefix + Y` | Copy to clipboard (yank) |

---

## 🔧 **Integrated Workflow**

### **Development Setup**
```bash
# Start tmux session
tm

# Open Neovim
prefix + N

# Open file manager
prefix + L

# Run tests
prefix + T

# Check git status
prefix + g
```

### **System Management**
```bash
# Update system
update

# Install package
install package-name

# Check system status
prefix + S

# Monitor system
prefix + H
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

## 🎯 **Quick Reference**

### **Most Used Commands**
| Component | Command | Action |
|-----------|---------|--------|
| Kitty | `Ctrl+Tab` | Next tab |
| Kitty | `Ctrl+Shift+Enter` | New tab |
| zsh | `Ctrl+R` | Search history |
| zsh | `Ctrl+A/E` | Line navigation |
| tmux | `prefix + c` | New window |
| tmux | `prefix + |` | Split vertical |
| tmux | `Alt+h/j/k/l` | Navigate panes |

### **Development Shortcuts**
| Command | Action |
|---------|--------|
| `tm` | Start tmux |
| `prefix + N` | Open Neovim |
| `prefix + L` | Open lf |
| `prefix + T` | Run tests |
| `prefix + g` | Git status |

### **System Shortcuts**
| Command | Action |
|---------|--------|
| `update` | Update system |
| `install` | Install package |
| `prefix + H` | System monitor |
| `prefix + S` | System status |

---

## 💡 **Tips**

### **Kitty Tips**
1. **Font Size**: Use `Ctrl+Equal/Minus` for quick font adjustment
2. **Tabs**: Use `Ctrl+1-9` for quick tab navigation
3. **Copy/Paste**: Use `Ctrl+Shift+C/V` for clipboard operations

### **zsh Tips**
1. **History**: Use `Ctrl+R` for command history search
2. **Completion**: Use `Tab` for intelligent completion
3. **Vi-mode**: Use `Esc` to enter normal mode for navigation

### **tmux Tips**
1. **Sessions**: Use `prefix + s` to switch between sessions
2. **Panes**: Use `Alt+Arrow` for quick pane navigation
3. **Copy**: Use `prefix + [` to enter copy mode

### **Integration Tips**
1. **Workflow**: Use `tm` to start development environment
2. **Tools**: Use prefix hotkeys for quick tool access
3. **Navigation**: Use consistent navigation patterns across tools

---

## 🐛 **Troubleshooting**

### **Common Issues**
| Issue | Solution |
|-------|----------|
| Kitty not responding | `Ctrl+Shift+Esc` to force quit |
| zsh slow | Disable unused plugins |
| tmux prefix not working | Check `prefix` key binding |
| Copy/paste not working | Check clipboard integration |

### **Reset Commands**
```bash
# Reload Kitty
kitty --reload-in-child

# Reload zsh
source ~/.zshrc

# Reload tmux
prefix + r
```

---

## 📚 **Learning Path**

### **Beginner**
1. Learn basic navigation in each tool
2. Master the prefix key in tmux
3. Practice vi-mode in zsh

### **Intermediate**
1. Use copy mode in tmux
2. Master history search in zsh
3. Learn tab management in Kitty

### **Advanced**
1. Customize hotkeys for your workflow
2. Create custom functions and aliases
3. Integrate with external tools

---

## 🔄 **Customization**

### **Adding Custom Hotkeys**
```bash
# Kitty
map your-key your-action

# zsh
bindkey 'your-key' your-action

# tmux
bind your-key your-action
```

### **Creating Aliases**
```bash
# Add to ~/.zshrc
alias your-alias='your-command'
```

### **Custom Functions**
```bash
# Add to ~/.zshrc
your-function() {
    your-commands
}
```
