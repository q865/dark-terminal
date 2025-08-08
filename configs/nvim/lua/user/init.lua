-- =============================================================================
-- ENHANCED NEOVIM CONFIGURATION FOR DARK-TERMINAL
-- =============================================================================

return {
  -- Set a colorscheme
  colorscheme = "nord",

  -- =============================================================================
  -- LSP CONFIGURATION
  -- =============================================================================
  lsp = {
    servers = {
      -- Core languages
      "bashls",
      "cssls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman", -- For markdown
      "prettier",
      "tailwindcss",
      "tsserver", -- For javascript and typescript
      "vimls",
      
      -- Additional languages
      "pyright", -- Python
      "rust_analyzer", -- Rust
      "gopls", -- Go
      "clangd", -- C/C++
      "cmake", -- CMake
      "dockerls", -- Docker
      "terraformls", -- Terraform
      "yamlls", -- YAML
      "eslint", -- JavaScript/TypeScript linting
      "stylelint_lsp", -- CSS/SCSS linting
      "sqls", -- SQL
      "graphql", -- GraphQL
      "prismals", -- Prisma
      "svelte", -- Svelte
      "volar", -- Vue
      "astro", -- Astro
      "emmet_ls", -- Emmet
      "unocss", -- UnoCSS
      "tailwindcss", -- Tailwind CSS
    },
    
    -- LSP settings
    config = {
      -- Global LSP settings
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              },
            },
          },
        },
      },
      
      -- TypeScript settings
      tsserver = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      
      -- Python settings
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },
      
      -- Rust settings
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
      },
    },
  },

  -- =============================================================================
  -- PLUGIN CONFIGURATION
  -- =============================================================================
  plugins = {
    init = {
      -- THEME_PLUGIN_START
      { "shaunsingh/nord.nvim" },
      -- THEME_PLUGIN_END
      
      -- Russian keyboard layout support
      {
        "m4xshen/hardtime.nvim",
        opts = {
          disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason" },
        },
      },
      
      -- Better terminal integration
      {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
          size = 20,
          open_mapping = [[<c-\>]],
          hide_numbers = true,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = true,
          direction = "float",
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
              border = "Normal",
              background = "Normal",
            },
          },
        },
      },
      
      -- Git integration
      {
        "lewis6991/gitsigns.nvim",
        opts = {
          signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
          },
          signcolumn = true,
          numhl = false,
          linehl = false,
          word_diff = false,
          watch_gitdir = {
            interval = 1000,
            follow_files = true,
          },
          attach_to_untracked = true,
          current_line_blame = false,
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
          },
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil,
          max_file_length = 40000,
          preview_config = {
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
          },
        },
      },
      
      -- File tree
      {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        },
        opts = {
          sources = { "filesystem", "buffers", "git_status", "document_symbols" },
          open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
          filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            window = {
              mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["<cr>"] = "open",
                ["<tab>"] = "preview",
                ["<c-v>"] = "open_vsplit",
                ["<c-s>"] = "open_split",
                ["<c-t>"] = "open_tabnew",
                ["<c-]>"] = "cd",
                ["<c-[>"] = "dir_up",
                ["<c-x>"] = "close_node",
                ["<c-r>"] = "refresh",
                ["<c-y>"] = "copy_name",
                ["<c-d>"] = "copy_path",
                ["<c-g>"] = "copy_absolute_path",
                ["<c-h>"] = "toggle_hidden",
                ["<c-f>"] = "filter_on_submit",
                ["<c-w>"] = "close_window",
                ["<c-t>"] = "open_tabnew",
                ["<c-v>"] = "open_vsplit",
                ["<c-s>"] = "open_split",
                ["<c-]>"] = "cd",
                ["<c-[>"] = "dir_up",
                ["<c-x>"] = "close_node",
                ["<c-r>"] = "refresh",
                ["<c-y>"] = "copy_name",
                ["<c-d>"] = "copy_path",
                ["<c-g>"] = "copy_absolute_path",
                ["<c-h>"] = "toggle_hidden",
                ["<c-f>"] = "filter_on_submit",
                ["<c-w>"] = "close_window",
              },
            },
          },
          buffers = {
            window = {
              mappings = {
                ["<cr>"] = "open",
                ["<c-v>"] = "open_vsplit",
                ["<c-s>"] = "open_split",
                ["<c-t>"] = "open_tabnew",
                ["<c-x>"] = "close_node",
                ["<c-r>"] = "refresh",
                ["<c-y>"] = "copy_name",
                ["<c-d>"] = "copy_path",
                ["<c-g>"] = "copy_absolute_path",
                ["<c-w>"] = "close_window",
              },
            },
          },
          git_status = {
            window = {
              mappings = {
                ["<cr>"] = "open",
                ["<c-v>"] = "open_vsplit",
                ["<c-s>"] = "open_split",
                ["<c-t>"] = "open_tabnew",
                ["<c-x>"] = "close_node",
                ["<c-r>"] = "refresh",
                ["<c-y>"] = "copy_name",
                ["<c-d>"] = "copy_path",
                ["<c-g>"] = "copy_absolute_path",
                ["<c-w>"] = "close_window",
              },
            },
          },
        },
      },
      
      -- Fuzzy finder
      {
        "nvim-telescope/telescope.nvim",
        opts = {
          defaults = {
            mappings = {
              i = {
                ["<c-t>"] = function(...)
                  return require("telescope.actions").select_tab(...)
                end,
                ["<c-v>"] = function(...)
                  return require("telescope.actions").select_vertical(...)
                end,
                ["<c-s>"] = function(...)
                  return require("telescope.actions").select_horizontal(...)
                end,
              },
            },
          },
        },
      },
      
      -- Better search and replace
      {
        "nvim-pack/nvim-spectre",
        opts = {
          open_cmd = "nosplit",
        },
      },
      
      -- Better comments
      {
        "numToStr/Comment.nvim",
        opts = {
          toggler = {
            line = "<leader>cc",
            block = "<leader>cb",
          },
          opleader = {
            line = "<leader>c",
            block = "<leader>b",
          },
        },
      },
      
      -- Better indentation
      {
        "echasnovski/mini.indentscope",
        opts = {
          symbol = "│",
          options = { try_as_border = true },
        },
      },
      
      -- Better status line
      {
        "rebelot/heirline.nvim",
        opts = function(_, opts)
          local status = require("astronvim.utils.status")
          opts.statusline = {
            hl = { fg = "fg", bg = "bg" },
            status.component.mode(),
            status.component.git_branch(),
            status.component.file_info(),
            status.component.git_diff(),
            status.component.diagnostics(),
            status.component.fill(),
            status.component.cmd_info(),
            status.component.fill(),
            status.component.lsp(),
            status.component.treesitter(),
            status.component.nav(),
          }
          return opts
        end,
      },
    },
  },

  -- =============================================================================
  -- CUSTOM SETTINGS
  -- =============================================================================
  polish = function()
    -- =============================================================================
    -- RUSSIAN KEYBOARD LAYOUT SUPPORT
    -- =============================================================================
    -- Map Russian keyboard layout to English for command mode
    vim.opt.langmap = "йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ.;qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>"
    
    -- =============================================================================
    -- ENHANCED KEYMAPPINGS
    -- =============================================================================
    local map = vim.keymap.set
    
    -- Leader key
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    
    -- =============================================================================
    -- GENERAL MAPPINGS
    -- =============================================================================
    -- Better window navigation
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
    
    -- Better buffer navigation
    map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
    map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
    
    -- Better search
    map("n", "n", "nzzzv", { desc = "Next search result" })
    map("n", "N", "Nzzzv", { desc = "Previous search result" })
    
    -- Better yanking
    map("n", "Y", "y$", { desc = "Yank to end of line" })
    
    -- =============================================================================
    -- DEVELOPMENT MAPPINGS
    -- =============================================================================
    -- LSP mappings
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
    map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    map("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
    map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format" })
    
    -- Telescope mappings
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
    map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Old files" })
    map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    map("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
    
    -- Neo-tree mappings
    map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
    map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus file tree" })
    
    -- Terminal mappings
    map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
    map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
    map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })
    
    -- =============================================================================
    -- TMUX INTEGRATION
    -- =============================================================================
    -- Send commands to tmux
    map("n", "<leader>ts", "<cmd>!tmux send-keys -t main:0.1 'cd %:p:h' Enter<cr>", { desc = "Send pwd to tmux" })
    map("n", "<leader>tr", "<cmd>!tmux send-keys -t main:0.1 'lf' Enter<cr>", { desc = "Send lf to tmux" })
    map("n", "<leader>tn", "<cmd>!tmux send-keys -t main:0.1 'nvim .' Enter<cr>", { desc = "Send nvim to tmux" })
    
    -- =============================================================================
    -- RUSSIAN LAYOUT SPECIFIC MAPPINGS
    -- =============================================================================
    -- Common Russian layout mappings for development
    map("n", "й", "q", { desc = "Russian q" })
    map("n", "ц", "w", { desc = "Russian w" })
    map("n", "у", "e", { desc = "Russian e" })
    map("n", "к", "r", { desc = "Russian r" })
    map("n", "е", "t", { desc = "Russian t" })
    map("n", "н", "y", { desc = "Russian y" })
    map("n", "г", "u", { desc = "Russian u" })
    map("n", "ш", "i", { desc = "Russian i" })
    map("n", "щ", "o", { desc = "Russian o" })
    map("n", "з", "p", { desc = "Russian p" })
    map("n", "х", "[", { desc = "Russian [" })
    map("n", "ъ", "]", { desc = "Russian ]" })
    map("n", "ф", "a", { desc = "Russian a" })
    map("n", "ы", "s", { desc = "Russian s" })
    map("n", "в", "d", { desc = "Russian d" })
    map("n", "а", "f", { desc = "Russian f" })
    map("n", "п", "g", { desc = "Russian g" })
    map("n", "р", "h", { desc = "Russian h" })
    map("n", "о", "j", { desc = "Russian j" })
    map("n", "л", "k", { desc = "Russian k" })
    map("n", "д", "l", { desc = "Russian l" })
    map("n", "ж", ";", { desc = "Russian ;" })
    map("n", "э", "'", { desc = "Russian '" })
    map("n", "я", "z", { desc = "Russian z" })
    map("n", "ч", "x", { desc = "Russian x" })
    map("n", "с", "c", { desc = "Russian c" })
    map("n", "м", "v", { desc = "Russian v" })
    map("n", "и", "b", { desc = "Russian b" })
    map("n", "т", "n", { desc = "Russian n" })
    map("n", "ь", "m", { desc = "Russian m" })
    map("n", "б", ",", { desc = "Russian ," })
    map("n", "ю", ".", { desc = "Russian ." })
    
    -- =============================================================================
    -- ENHANCED SETTINGS
    -- =============================================================================
    -- Better search
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    
    -- Better editing
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.autoindent = true
    vim.opt.smartindent = true
    
    -- Better display
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = false
    vim.opt.signcolumn = "yes"
    vim.opt.colorcolumn = "80"
    
    -- Better performance
    vim.opt.lazyredraw = true
    vim.opt.synmaxcol = 240
    vim.opt.updatetime = 300
    
    -- Better backup
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.swapfile = false
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
    
    -- Better completion
    vim.opt.completeopt = "menu,menuone,noselect"
    vim.opt.wildmenu = true
    vim.opt.wildmode = "longest:full,full"
    
    -- Better terminal
    vim.opt.termguicolors = true
    vim.opt.scrolloff = 8
    vim.opt.sidescrolloff = 8
    
    -- =============================================================================
    -- AUTOCOMMANDS
    -- =============================================================================
    -- Auto-resize splits
    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        vim.cmd("tabdo wincmd =")
      end,
    })
    
    -- Auto-format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        vim.lsp.buf.format()
      end,
    })
    
    -- Auto-close quickfix
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "qf" },
      callback = function()
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
      end,
    })
    
    -- =============================================================================
    -- CUSTOM FUNCTIONS
    -- =============================================================================
    -- Function to toggle between Russian and English layouts
    vim.api.nvim_create_user_command("ToggleLayout", function()
      local current_layout = vim.opt.langmap:get()
      if current_layout == "" then
        vim.opt.langmap = "йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ.;qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>"
        vim.notify("Russian layout enabled", vim.log.levels.INFO)
      else
        vim.opt.langmap = ""
        vim.notify("English layout enabled", vim.log.levels.INFO)
      end
    end, {})
    
    -- Function to send current file to tmux
    vim.api.nvim_create_user_command("SendToTmux", function()
      local file_path = vim.fn.expand("%:p")
      vim.cmd("!tmux send-keys -t main:0.1 'cd " .. vim.fn.fnamemodify(file_path, ":h") .. "' Enter")
    end, {})
    
    -- Function to open terminal in current directory
    vim.api.nvim_create_user_command("TermHere", function()
      vim.cmd("ToggleTerm direction=float dir=" .. vim.fn.expand("%:p:h"))
    end, {})
    
    -- =============================================================================
    -- STATUS LINE ENHANCEMENTS
    -- =============================================================================
    -- Show current layout in status line
    vim.opt.statusline = vim.opt.statusline:get() .. " %{&langmap != '' ? '[RU]' : '[EN]'}"
    
    -- =============================================================================
    -- NOTIFICATIONS
    -- =============================================================================
    -- Welcome message
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.notify("Welcome to dark-terminal Neovim!", vim.log.levels.INFO, {
          title = "dark-terminal",
          timeout = 3000,
        })
      end,
    })
  end,
}
