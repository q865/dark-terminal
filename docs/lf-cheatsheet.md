# lf Hotkeys Cheatsheet

## 🎯 **Neovim Integration**
| Key | Action |
|-----|--------|
| `e` | Open file in Neovim |
| `E` | Open file in Neovim |
| `t` | Open file in Neovim (new tab) |
| `v` | Open file in Neovim (vertical split) |
| `s` | Open file in Neovim (horizontal split) |
| `l` | Open file in Neovim at specific line |
| `L` | Quick edit in Neovim at specific line |

## 📁 **File Operations**
| Key | Action |
|-----|--------|
| `o` | Open file with default app |
| `O` | Open file with default app |
| `mp` | Open video with mpv |
| `zp` | Open PDF with zathura |
| `ff` | Open URL with Firefox |
| `ch` | Open URL with Chromium |

## 🧭 **Navigation**
| Key | Action |
|-----|--------|
| `gh` | Go to home directory |
| `gd` | Go to Downloads |
| `gp` | Go to Pictures |
| `gv` | Go to Videos |
| `gm` | Go to Music |
| `gD` | Go to Documents |
| `gc` | Go to .config |
| `gs` | Go to dev_projects |
| `<backspace>` | Go to parent directory |
| `h` | Go to parent directory |

## 🔍 **Search & Filter**
| Key | Action |
|-----|--------|
| `<Ctrl+f>` | Fuzzy finder for files |
| `<Ctrl+p>` | Fuzzy finder for projects |
| `/` | Search files in current directory |
| `?` | Search directories in current directory |
| `<Ctrl+e>` | Filter by extension |
| `<Ctrl+r>` | Reverse filter |

## 📋 **File Management**
| Key | Action |
|-----|--------|
| `yy` | Copy file |
| `dd` | Move file |
| `pp` | Paste file |
| `a` | Create new file |
| `A` | Create new directory |
| `d` | Delete file |
| `D` | Force delete file |
| `r` | Rename file |

## 👁️ **Preview**
| Key | Action |
|-----|--------|
| `zp` | Toggle preview |
| `pv` | Preview file |
| `ph` | Preview here |

## 🎭 **Tmux Integration**
| Key | Action |
|-----|--------|
| `tm` | Send file to tmux |
| `tM` | Send all files to tmux |

## 🔧 **Git Operations**
| Key | Action |
|-----|--------|
| `gs` | Git status |
| `ga` | Git add file |
| `gc` | Git commit |
| `gp` | Git push |
| `gl` | Git log |

## ⚙️ **System Operations**
| Key | Action |
|-----|--------|
| `<Ctrl+t>` | Toggle terminal |
| `<Ctrl+z>` | Suspend |
| `<Ctrl+l>` | Clear |
| `<Ctrl+r>` | Reload |

## 🚀 **Development**
| Key | Action |
|-----|--------|
| `dev` | Setup development environment |
| `test` | Run tests |
| `build` | Build project |

## 🔧 **Advanced Features**
| Key | Action |
|-----|--------|
| `diff` | Compare files |
| `tar` | Create archive |
| `untar` | Extract archive |
| `wget` | Download file |
| `curl` | Fetch URL |

## 📱 **Vim-like Navigation**
| Key | Action |
|-----|--------|
| `j` | Down |
| `k` | Up |
| `h` | Up |
| `l` | Down |
| `<Ctrl+d>` | Down page |
| `<Ctrl+u>` | Up page |
| `<Ctrl+f>` | Down page |
| `<Ctrl+b>` | Up page |
| `gg` | Top |
| `G` | Bottom |

## 🏷️ **Mark Operations**
| Key | Action |
|-----|--------|
| `m` | Mark |
| `u` | Unmark |
| `t` | Toggle |
| `c` | Clear |

## 🎯 **Page Navigation**
| Key | Action |
|-----|--------|
| `mousewheelup` | Preview page up |
| `mousewheeldown` | Preview page down |
| `mouseup` | Preview page up |
| `mousedown` | Preview page down |

## 📊 **Window Management**
| Key | Action |
|-----|--------|
| `<Ctrl+Shift+Enter>` | New tab |
| `<Ctrl+Shift+t>` | New window |
| `<Ctrl+Shift+w>` | Close tab |

## 📋 **Copy/Paste**
| Key | Action |
|-----|--------|
| `<Ctrl+c>` | Copy to clipboard |
| `<Ctrl+v>` | Paste from clipboard |

## 🧹 **Terminal**
| Key | Action |
|-----|--------|
| `<Ctrl+Shift+k>` | Clear terminal |

---

## 🚀 **Quick Functions**

### **lfcd()**
```bash
lfcd [directory]
```
Open lf and change to selected directory.

### **lfnvim()**
```bash
lfnvim [directory]
```
Open lf and open selected file in Neovim.

### **lfdev()**
```bash
lfdev [project_directory]
```
Setup development environment with tmux and Neovim.

### **lfgit()**
```bash
lfgit [directory]
```
Open lf with git repository detection.

---

## 🎨 **Preview Support**

### **Text Files**
- Syntax highlighting with `bat`
- Line numbers
- Color coding

### **Images**
- ASCII art with `chafa`
- Alternative with `viu`

### **Videos**
- Metadata with `ffprobe`
- Duration, codec, resolution

### **Documents**
- PDF with `pdftotext`
- Word with `antiword`
- Spreadsheets with `ssconvert`

### **Archives**
- Contents listing
- Support for tar, zip, rar, 7z

---

## 🔧 **Configuration Files**

- **lfrc**: `~/.config/lf/lfrc`
- **rifle.conf**: `~/.config/lf/rifle.conf`
- **preview**: `~/.config/lf/preview`

---

## 💡 **Tips**

1. **Use `e` for quick editing** - Opens files directly in Neovim
2. **Use `o` for opening** - Uses smart application detection
3. **Use `gh` for quick navigation** - Jump to common directories
4. **Use `<Ctrl+f>` for fuzzy finding** - Fast file search
5. **Use `dev` for project setup** - Automatic development environment

---

## 🐛 **Troubleshooting**

### **Preview not working**
```bash
# Install required tools
sudo pacman -S bat chafa ffmpeg

# Check permissions
chmod +x ~/.config/lf/preview
```

### **Neovim integration not working**
```bash
# Check Neovim installation
which nvim

# Check tmux session
tmux list-sessions
```

### **File opening not working**
```bash
# Install applications
sudo pacman -S zathura mpv firefox

# Test rifle configuration
rifle /path/to/file
```
