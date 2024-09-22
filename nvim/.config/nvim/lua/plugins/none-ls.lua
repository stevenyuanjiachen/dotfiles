return {
	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
        -- lua
				null_ls.builtins.formatting.stylua,
        -- python
				null_ls.builtins.formatting.black,
        -- C/C++
				null_ls.builtins.formatting.clang_format,

			},
		})

		-- keymaps
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
