# Enhanced Neovim Integration for dark-terminal

## Overview

This document describes the enhanced Neovim configuration in dark-terminal, which provides seamless integration with Russian keyboard layout, tmux, and comprehensive development tools.

## 🎯 **Key Features**

### **Russian Keyboard Layout Support**
- **Automatic Mapping**: Russian keys mapped to English equivalents
- **Toggle Function**: `:ToggleLayout` to switch between layouts
- **Status Indicator**: Shows current layout in status line
- **Seamless Integration**: Works with all Neovim commands

### **Enhanced LSP Support**
- **Multiple Languages**: Python, Rust, Go, TypeScript, C/C++, and more
- **Auto-installation**: Automatic LSP server installation
- **Advanced Features**: Code actions, refactoring, diagnostics
- **Language-specific Settings**: Optimized for each language

### **Tmux Integration**
- **Command Sending**: Send commands to tmux sessions
- **File Operations**: Open files in tmux panes
- **Directory Sync**: Synchronize working directories
- **Session Management**: Integrated session handling

## 🎨 **Theme Integration**

### **Supported Themes**
- **Nord** (default) - Cool blue tones
- **Catppuccin** - Soothing pastel colors
- **Dracula** - Dark purple and green
- **Tokyo Night** - Deep blue and purple
- **Gruvbox** - Warm brown and green
- **Everforest** - Natural green and brown
- **Rosé Pine** - Elegant pink and blue

### **Theme Synchronization**
```bash
# Change theme across all components
./scripts/theme-switcher.sh tokyonight

# List available themes
./scripts/theme-switcher.sh list

# Preview theme
./scripts/theme-switcher.sh preview dracula
```

## ⌨️ **Russian Keyboard Layout**

### **Automatic Mapping**
The configuration automatically maps Russian keys to English equivalents:

| Russian | English | Description |
|---------|---------|-------------|
| `й` | `q` | Quit, Quick |
| `ц` | `w` | Write, Window |
| `у` | `e` | End, Edit |
| `к` | `r` | Replace, Redo |
| `е` | `t` | Tag, Terminal |
| `н` | `y` | Yank |
| `г` | `u` | Undo |
| `ш` | `i` | Insert |
| `щ` | `o` | Open |
| `з` | `p` | Paste |
| `х` | `[` | Bracket |
| `ъ` | `]` | Bracket |
| `ф` | `a` | Append |
| `ы` | `s` | Substitute |
| `в` | `d` | Delete |
| `а` | `f` | Find |
| `п` | `g` | Go |
| `р` | `h` | Home |
| `о` | `j` | Down |
| `л` | `k` | Up |
| `д` | `l` | Right |
| `ж` | `;` | Semicolon |
| `э` | `'` | Quote |
| `я` | `z` | Zoom |
| `ч` | `x` | Cut |
| `с` | `c` | Change |
| `м` | `v` | Visual |
| `и` | `b` | Back |
| `т` | `n` | Next |
| `ь` | `m` | Mark |
| `б` | `,` | Comma |
| `ю` | `.` | Period |

### **Layout Toggle**
```vim
:ToggleLayout  " Switch between Russian and English layouts
```

### **Status Line Indicator**
The status line shows the current layout:
- `[RU]` - Russian layout active
- `[EN]` - English layout active

## 🔧 **Enhanced Keymappings**

### **General Navigation**
| Key | Action | Description |
|-----|--------|-------------|
| `<C-h/j/k/l>` | Window navigation | Navigate between windows |
| `<S-h/l>` | Buffer navigation | Previous/Next buffer |
| `n/N` | Search navigation | Next/Previous search result |
| `Y` | Yank to end | Yank to end of line |

### **Development Features**
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | LSP definition |
| `gr` | Go to references | LSP references |
| `gi` | Go to implementation | LSP implementation |
| `gt` | Go to type definition | LSP type definition |
| `K` | Hover | LSP hover |
| `<leader>ca` | Code action | LSP code action |
| `<leader>rn` | Rename | LSP rename |
| `<leader>f` | Format | LSP format |

### **File Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find files | Telescope find files |
| `<leader>fg` | Live grep | Telescope live grep |
| `<leader>fb` | Find buffers | Telescope buffers |
| `<leader>fo` | Old files | Telescope old files |
| `<leader>e` | File tree | Toggle Neo-tree |
| `<leader>o` | Focus tree | Focus Neo-tree |

### **Terminal Integration**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tt` | Toggle terminal | Toggle terminal |
| `<leader>tf` | Float terminal | Float terminal |
| `<leader>th` | Horizontal terminal | Horizontal terminal |
| `<leader>tv` | Vertical terminal | Vertical terminal |
| `<C-\>` | Quick terminal | Quick terminal toggle |

### **Tmux Integration**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ts` | Send pwd to tmux | Send current directory |
| `<leader>tr` | Send lf to tmux | Send file manager |
| `<leader>tn` | Send nvim to tmux | Send editor |

## 🚀 **LSP Configuration**

### **Supported Languages**
- **Core**: Bash, CSS, HTML, JSON, Lua, Markdown, Prettier, Tailwind, TypeScript, Vim
- **Python**: Pyright with type checking and formatting
- **Rust**: Rust-analyzer with clippy
- **Go**: Gopls with formatting
- **C/C++**: Clangd with CMake support
- **Web**: Vue, Svelte, Astro, GraphQL, Prisma
- **DevOps**: Docker, Terraform, YAML
- **Tools**: ESLint, Stylelint, SQL

### **LSP Settings**
```lua
-- TypeScript settings
tsserver = {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

-- Python settings
pyright = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
      },
    },
  },
}

-- Rust settings
rust_analyzer = {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { allFeatures = true },
    },
  },
}
```

## 🎭 **Plugin Integration**

### **Core Plugins**
- **AstroNvim**: Base framework
- **ToggleTerm**: Terminal integration
- **Neo-tree**: File tree
- **Telescope**: Fuzzy finder
- **Gitsigns**: Git integration
- **Comment.nvim**: Better comments
- **Mini.indentscope**: Indentation guides

### **Development Plugins**
- **LSP**: Language Server Protocol
- **TreeSitter**: Syntax highlighting
- **Mason**: Package manager
- **Null-ls**: Code formatting
- **Trouble**: Diagnostic viewer

## 🔧 **Custom Functions**

### **Layout Management**
```vim
:ToggleLayout  " Toggle between Russian and English layouts
```

### **Tmux Integration**
```vim
:SendToTmux   " Send current file path to tmux
:TermHere     " Open terminal in current directory
```

### **Development Workflow**
```vim
:Format       " Format current buffer
:LspInfo      " Show LSP information
:TSBufInfo    " Show TreeSitter information
:Mason        " Open Mason interface
```

## 📋 **Installation**

### **Automatic Setup**
```bash
# Run the Neovim setup script
./scripts/nvim-setup.sh
```

### **Manual Installation**
```bash
# Install system dependencies
sudo pacman -S nodejs npm rust go python-pip

# Install Neovim components
nvim --headless -c "LspInstall bashls cssls html jsonls lua_ls"
nvim --headless -c "TSInstall bash c css go html javascript json lua markdown python rust typescript"
nvim --headless -c "MasonInstall bash-language-server css-lsp html-lsp json-lsp lua-language-server"
```

## 🎨 **Theme Configuration**

### **Changing Themes**
```bash
# Change to Tokyo Night theme
./scripts/theme-switcher.sh tokyonight

# Preview Dracula theme
./scripts/theme-switcher.sh preview dracula

# List all themes
./scripts/theme-switcher.sh list
```

### **Custom Theme**
```lua
-- Add custom theme to init.lua
plugins = {
  init = {
    { "your-theme/theme-name" },
  },
}

-- Set colorscheme
colorscheme = "your-theme"
```

## 🔧 **Configuration Files**

### **Main Configuration**
- **File**: `~/.config/nvim/lua/user/init.lua`
- **Purpose**: Main Neovim configuration
- **Features**: LSP, plugins, keymappings

### **AstroNvim Configuration**
- **File**: `~/.config/nvim/init.lua`
- **Purpose**: AstroNvim framework
- **Features**: Base configuration

### **LSP Configuration**
- **File**: `~/.config/nvim/lua/user/init.lua`
- **Purpose**: Language server settings
- **Features**: Language-specific configurations

## 🚀 **Usage Examples**

### **Basic Development**
```vim
" Open file tree
<leader>e

" Find files
<leader>ff

" Search in files
<leader>fg

" Open terminal
<leader>tt

" Go to definition
gd

" Rename symbol
<leader>rn
```

### **Russian Layout Usage**
```vim
" Switch to Russian layout
:ToggleLayout

" Use Russian keys for navigation
й  " q - quit
ц  " w - write
у  " e - end
к  " r - replace
е  " t - tag
н  " y - yank
г  " u - undo
ш  " i - insert
щ  " o - open
з  " p - paste
```

### **Tmux Integration**
```vim
" Send current directory to tmux
<leader>ts

" Open file manager in tmux
<leader>tr

" Open editor in tmux
<leader>tn
```

## 🐛 **Troubleshooting**

### **Common Issues**

#### **LSP Not Working**
```bash
# Check LSP installation
:LspInfo

# Reinstall LSP servers
:LspInstall <server-name>

# Check Mason installation
:Mason
```

#### **Russian Layout Not Working**
```vim
" Check current layout
:echo &langmap

" Reset layout
:set langmap=

" Enable Russian layout
:set langmap=йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ.;qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>
```

#### **Theme Not Syncing**
```bash
# Reload tmux configuration
tmux source-file ~/.config/tmux/tmux.conf

# Restart Kitty
pkill kitty

# Sync Neovim plugins
nvim --headless "+Lazy! sync" +qa
```

### **Debug Commands**
```vim
" Check Neovim version
:version

" Check LSP status
:LspInfo

" Check TreeSitter status
:TSBufInfo

" Check Mason status
:Mason

" Check key mappings
:map

" Check options
:set
```

## 📚 **Additional Resources**

### **Documentation**
- **AstroNvim**: https://astronvim.com/
- **Neovim**: https://neovim.io/
- **LSP**: https://microsoft.github.io/language-server-protocol/
- **TreeSitter**: https://tree-sitter.github.io/tree-sitter/

### **Plugins**
- **ToggleTerm**: https://github.com/akinsho/toggleterm.nvim
- **Neo-tree**: https://github.com/nvim-neo-tree/neo-tree.nvim
- **Telescope**: https://github.com/nvim-telescope/telescope.nvim
- **Gitsigns**: https://github.com/lewis6991/gitsigns.nvim

### **Themes**
- **Nord**: https://github.com/shaunsingh/nord.nvim
- **Catppuccin**: https://github.com/catppuccin/nvim
- **Tokyo Night**: https://github.com/folke/tokyonight.nvim
- **Gruvbox**: https://github.com/ellisonleao/gruvbox.nvim

## 🤝 **Contributing**

To contribute to the Neovim integration:

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes**
4. **Test thoroughly**
5. **Submit a pull request**

### **Testing**
```bash
# Test Neovim configuration
nvim --headless -c "source ~/.config/nvim/init.lua"

# Test LSP installation
nvim --headless -c "LspInstall bashls"

# Test theme switching
./scripts/theme-switcher.sh nord
```

---

## 📄 **License**

This Neovim integration is part of the dark-terminal project and follows the same license terms.
