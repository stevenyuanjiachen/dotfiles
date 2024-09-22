local opt = vim.opt

-- line number
opt.relativenumber = true
opt.number = true

-- Ident
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- ban wrap
opt.wrap = false

-- enable the mouse
opt.mouse:append("a")

-- new windows default right/down
opt.splitright = true
opt.splitbelow = true

-- fuzzy search
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- use the system clipboard
opt.clipboard:append("unnamedplus")
