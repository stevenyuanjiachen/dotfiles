local function check_backspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

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
      local luasnip = require("luasnip")
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
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),  -- 取消补全，esc也可以退出
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, {
              "i",
              "s",
            }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
              "i",
              "s",
            }),
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
