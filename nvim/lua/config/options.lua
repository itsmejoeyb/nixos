vim.g.netrw_banner = 0

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2

opt.scrolloff = 8

opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true

opt.background = "dark"
opt.signcolumn = "yes"
opt.termguicolors = true
opt.winborder = "rounded"

opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.undofile = true
opt.updatetime = 250

vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
