return {
  -- mason
  {
    "williamboman/mason.nvim",
    lazy = false,

    config = function()
      require("mason").setup()
    end
  },

  -- mason-lsp: to install the lsp
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "cmake", "clangd", "bashls"}
      })
    end
  },

  -- nvim-lsp: hook up the neovim and the lsp
  {
    "neovim/nvim-lspconfig",
    lazy = false,

    config = function()
      local lspconfig = require("lspconfig")

      -- lsp that used
      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.cmake.setup({})

      -- keymap
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    end,
  },
}