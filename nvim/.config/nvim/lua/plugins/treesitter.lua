return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "javascript", "cpp", "python", "c" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },

      -- rainbow ()
      rainbow = {
				enable = true,
				extended_mode = true, -- 启用超过两个括号的情况
				max_file_lines = nil, -- 不限制文件行数
			},
		})
	end,
}
