return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    -- setup neo-tree
    require("neo-tree").setup({
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
      -- Show the hidden file
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,  -- 设置为 false 以显示隐藏文件
        },
      },
    })

    -- keymap
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
  end
}
