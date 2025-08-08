# Enhanced lf Integration for dark-terminal

## Overview

This document describes the enhanced lf (file manager) integration in dark-terminal, which provides seamless workflow between lf, Neovim, and tmux.

## Features

### 🔥 **Core Integration**
- **Neovim Integration**: Open files directly in Neovim from lf
- **Tmux Integration**: Send files to specific tmux panes
- **Smart Preview**: Enhanced file previews with syntax highlighting
- **Git Integration**: Git operations directly from lf
- **Project Detection**: Automatic project type detection and setup

### 🎯 **Hotkeys in lf**

#### **Neovim Integration**
- `e` - Open file in Neovim (current pane)
- `E` - Open file in Neovim (current pane)
- `t` - Open file in Neovim (new tab)
- `v` - Open file in Neovim (vertical split)
- `s` - Open file in Neovim (horizontal split)
- `l` - Open file in Neovim at specific line
- `L` - Quick edit in Neovim at specific line

#### **File Operations**
- `o` - Open file with default application
- `O` - Open file with default application
- `mp` - Open video with mpv
- `zp` - Open PDF with zathura
- `ff` - Open URL with Firefox
- `ch` - Open URL with Chromium

#### **Navigation**
- `gh` - Go to home directory
- `gd` - Go to Downloads
- `gp` - Go to Pictures
- `gv` - Go to Videos
- `gm` - Go to Music
- `gD` - Go to Documents
- `gc` - Go to .config
- `gs` - Go to dev_projects
- `<backspace>` - Go to parent directory
- `h` - Go to parent directory

#### **Search and Filtering**
- `<Ctrl+f>` - Fuzzy finder for files
- `<Ctrl+p>` - Fuzzy finder for projects
- `/` - Search files in current directory
- `?` - Search directories in current directory
- `<Ctrl+e>` - Filter by extension
- `<Ctrl+r>` - Reverse filter

#### **File Management**
- `yy` - Copy file
- `dd` - Move file
- `pp` - Paste file
- `a` - Create new file
- `A` - Create new directory
- `d` - Delete file
- `D` - Force delete file
- `r` - Rename file

#### **Preview Enhancements**
- `zp` - Toggle preview
- `pv` - Preview file
- `ph` - Preview here

#### **Tmux Integration**
- `tm` - Send file to tmux
- `tM` - Send all files to tmux

#### **Git Operations**
- `gs` - Git status
- `ga` - Git add file
- `gc` - Git commit
- `gp` - Git push
- `gl` - Git log

#### **System Operations**
- `<Ctrl+t>` - Toggle terminal
- `<Ctrl+z>` - Suspend
- `<Ctrl+l>` - Clear
- `<Ctrl+r>` - Reload

#### **Development Helpers**
- `dev` - Setup development environment
- `test` - Run tests
- `build` - Build project

#### **Advanced Features**
- `diff` - Compare files
- `tar` - Create archive
- `untar` - Extract archive
- `wget` - Download file
- `curl` - Fetch URL

### 🎨 **Enhanced Preview System**

The improved preview script supports:

#### **Text Files**
- Syntax highlighting with `bat`
- Line numbers
- Color coding
- File information

#### **Images**
- ASCII art preview with `chafa`
- Alternative with `viu` or `catimg`
- Image information display

#### **Videos**
- Video metadata with `ffprobe`
- Duration, codec, resolution
- File size and format

#### **Audio**
- Audio metadata with `ffprobe`
- Duration and bitrate
- Format information

#### **Documents**
- PDF text extraction with `pdftotext`
- Word documents with `antiword`
- Spreadsheets with `ssconvert`
- OpenDocument with `pandoc`

#### **Archives**
- Archive contents listing
- Support for tar, zip, rar, 7z
- File count and size

### 🔧 **Configuration Files**

#### **lfrc** (`~/.config/lf/lfrc`)
Enhanced configuration with:
- Vim-like navigation
- Extended hotkeys
- Neovim integration
- Tmux integration
- Git operations
- File operations

#### **rifle.conf** (`~/.config/lf/rifle.conf`)
Smart file opening with:
- Application detection
- Desktop vs headless support
- Multiple application fallbacks
- Format-specific handlers

#### **preview** (`~/.config/lf/preview`)
Enhanced preview script with:
- Multiple format support
- Syntax highlighting
- Binary detection
- File information

### 🚀 **Additional Functions**

#### **lfcd()**
```bash
lfcd [directory]
```
Open lf and change to selected directory.

#### **lfnvim()**
```bash
lfnvim [directory]
```
Open lf and open selected file in Neovim.

#### **lfopen()**
```bash
lfopen [directory]
```
Open lf and open selected file with default application.

#### **lfdev()**
```bash
lfdev [project_directory]
```
Setup development environment with tmux and Neovim.

#### **lfgit()**
```bash
lfgit [directory]
```
Open lf with git repository detection.

#### **lfproj()**
```bash
lfproj [directory]
```
Open lf with project type detection and setup.

### 🎯 **Tmux Integration Functions**

#### **lftmux()**
```bash
lftmux <file> [session] [pane]
```
Send file to specific tmux pane.

#### **lftmuxlf()**
```bash
lftmuxlf [session] [pane]
```
Open lf in specific tmux pane.

#### **lftmuxlayout()**
```bash
lftmuxlayout [session]
```
Setup tmux layout with Neovim, lf, and terminal.

### 📁 **File Operation Functions**

#### **lfcp()**
```bash
lfcp <file1> <file2> ... <destination>
```
Copy multiple files to destination.

#### **lfmv()**
```bash
lfmv <file1> <file2> ... <destination>
```
Move multiple files to destination.

#### **lfbackup()**
```bash
lfbackup <file>
```
Create timestamped backup of file.

#### **lfdiff()**
```bash
lfdiff <file1> <file2>
```
Compare files with syntax highlighting.

### 🔍 **Search Functions**

#### **lfsearch()**
```bash
lfsearch <pattern>
```
Search files by name pattern.

#### **lfcontent()**
```bash
lfcontent <pattern>
```
Search content in files.

#### **lfext()**
```bash
lfext <extension>
```
Filter files by extension.

### 📦 **Archive Functions**

#### **lfarchive()**
```bash
lfarchive <file1> <file2> ...
```
Create archive from files.

#### **lfextract()**
```bash
lfextract <archive> [destination]
```
Extract archive to destination.

### 🔧 **Git Functions**

#### **lfgitstatus()**
Show git status with file previews.

#### **lfgitadd()**
```bash
lfgitadd <file1> <file2> ...
```
Add files to git.

#### **lfgitcommit()**
```bash
lfgitcommit [message]
```
Commit changes with optional message.

### 🛠 **System Functions**

#### **lfinfo()**
```bash
lfinfo <file>
```
Show detailed file information.

#### **lfnew()**
```bash
lfnew <filename>
```
Create new file and open in Neovim.

#### **lfmkdir()**
```bash
lfmkdir <dirname>
```
Create new directory and navigate to it.

## Installation

The enhanced lf integration is automatically installed with dark-terminal. The configuration files are:

1. **lfrc** - Main lf configuration
2. **rifle.conf** - File opening rules
3. **preview** - Enhanced preview script
4. **lf-integration.sh** - Integration functions
5. **lf-aliases.sh** - Additional aliases

## Usage Examples

### Basic File Navigation
```bash
# Open lf in current directory
lf

# Open lf and change to selected directory
lfcd

# Open lf and open selected file in Neovim
lfnvim
```

### Development Workflow
```bash
# Setup development environment
lfdev my-project

# Open project with git integration
lfgit

# Open project with automatic setup
lfproj
```

### File Operations
```bash
# Copy multiple files
lfcp file1.txt file2.txt destination/

# Create backup
lfbackup important-file.txt

# Compare files
lfdiff old.txt new.txt
```

### Search Operations
```bash
# Search files by name
lfsearch "config"

# Search content in files
lfcontent "function"

# Filter by extension
lfext "py"
```

### Archive Operations
```bash
# Create archive
lfarchive file1.txt file2.txt

# Extract archive
lfextract archive.tar.gz
```

## Troubleshooting

### Common Issues

1. **Preview not working**
   - Install required tools: `bat`, `chafa`, `ffmpeg`
   - Check file permissions on preview script

2. **Neovim integration not working**
   - Ensure Neovim is installed and in PATH
   - Check tmux session configuration

3. **File opening not working**
   - Install required applications (zathura, mpv, etc.)
   - Check rifle.conf configuration

### Debug Commands

```bash
# Check lf configuration
lf -config

# Test preview script
~/.config/lf/preview /path/to/file 80 24

# Test rifle configuration
rifle /path/to/file

# Check tmux integration
tmux list-sessions
```

## Customization

### Adding Custom Hotkeys

Edit `~/.config/lf/lfrc`:
```bash
# Custom hotkey example
map <your-key> $your-command $f
```

### Adding Custom File Types

Edit `~/.config/lf/rifle.conf`:
```bash
# Custom file type example
ext your-extension, has your-app, label your-label = your-app "$@"
```

### Adding Custom Preview

Edit `~/.config/lf/preview`:
```bash
# Custom preview example
*.your-extension)
    your-preview-command "$file_path"
    ;;
```

## Dependencies

### Required Tools
- `lf` - File manager
- `nvim` - Editor
- `tmux` - Terminal multiplexer
- `bat` - File previewer
- `fzf` - Fuzzy finder

### Optional Tools
- `chafa` - Image preview
- `ffmpeg` - Media information
- `zathura` - PDF viewer
- `mpv` - Media player
- `pandoc` - Document converter

## Contributing

To add new features or improve the integration:

1. Edit the appropriate configuration file
2. Test your changes
3. Update this documentation
4. Submit a pull request

## License

This integration is part of the dark-terminal project and follows the same license terms.
