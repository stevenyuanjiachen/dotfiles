return {
  -- LuaSnip: the Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      -- The Snippet that the Luasnip use, provide VScode snippet
      "rafamadriz/friendly-snippets",
    },
  },

  -- Nvim-cmp: the Completion Engine that require the Snippet Engine
  {
    "hrsh7th/nvim-cmp",

    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- the snippet engine that nvim-cmp use
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- the window of the nvim-cmp
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- keymaps
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources(
        {
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, 
        {
            { name = "buffer" },
        }),
      })
    end,
  },

  -- the package used to communiacte between the LSP and cmp engine
  {
    "hrsh7th/cmp-nvim-lsp"
  },
}
