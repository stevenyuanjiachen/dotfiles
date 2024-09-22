-- Alpha (dashboard) for neovim
local options

if (vim.api.nvim_exec('echo argc()', true) == "0") then
  local function button(sc, txt, hl, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
      position       = "center",
      shortcut       = '['..sc..']',
      cursor         = 48,
      width          = 50,
      align_shortcut = "right",
      hl_shortcut    = hl,
    }

    if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
      opts.keymap = {"n", sc_, keybind, keybind_opts}
    end

    local function on_press()
      local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
      type     = "button",
      val      = txt,
      on_press = on_press,
      opts     = opts,
    }
  end

  local header = {
    type = "text",
    val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    },
    opts = {
      position = "center",
      hl       = "AlphaHeader",
    }
  }

  local buttons = {
    type = "group",
    val = {
      button("e", "  New Buffer", 'RainbowRed', ':tabnew<CR>'),
      button("f", "  Find file", 'RainbowYellow', ':Telescope find_files<CR>'),
      button("h", "  Recently opened files", 'RainbowBlue', ':Telescope oldfiles<CR>'),
      button("l", "  Projects", 'RainbowOrange', ':Telescope marks<CR>'),
      button("g", "  Open Last Session", 'RainbowGreen', ':source ~/.config/nvim/session.vim<CR>'),
    },
    opts = {
      spacing = 1,
    }
  }

  options = {
    layout = {
      { type = "padding", val = 2 },
      header,
      { type = "padding", val = 1 },
      buttons,
    },
    opts = {
      margin = 5
    },
  }

  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#4B8AFF" }) -- 蓝色高亮

  -- 监听回车键
  vim.api.nvim_set_keymap('n', '<CR>', ':lua require\'alpha\'.setup(options)<CR>', { noremap = true, silent = true })
end

return {
  "goolord/alpha-nvim",
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function ()
    if options then
      require'alpha'.setup(options)
    end
  end
}
