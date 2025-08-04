-- You can add your own custom AstroNvim settings here
-- For example:
-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   opts = {
--     flavour = "macchiato",
--   },
-- }
--
-- For more information, see: https://astronvim.com/configuration/user_config
return {
  -- AstroNvim uses mason-lspconfig to manage servers, so we can configure it here
  lsp = {
    -- enable servers that you already have installed on your system
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
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      --
      -- You can also add new plugins here as well:
      -- {
      --   "andweeb/presence.nvim",
      --   config = function()
      --     require("presence"):setup {}
      --   end,
      -- },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
  },
}