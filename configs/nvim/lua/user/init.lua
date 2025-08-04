-- You can add your own custom AstroNvim settings here
return {
  -- Set a colorscheme
  colorscheme = "nord",

  -- AstroNvim uses mason-lspconfig to manage servers, so we can configure it here
  lsp = {
    servers = {
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
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      -- THEME_PLUGIN_START
      { "shaunsingh/nord.nvim" },
      -- THEME_PLUGIN_END

      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
    },
  },
}