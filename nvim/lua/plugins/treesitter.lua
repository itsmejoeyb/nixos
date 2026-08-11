local parsers = {
	"bash",
	"c",
	"css",
	"dockerfile",
	"gitignore",
	"go",
	"graphql",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"prisma",
	"query",
	"svelte",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.setup()
		treesitter.install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
			callback = function(args)
				local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if language and vim.treesitter.language.add(language) then
					vim.treesitter.start(args.buf, language)
				end
			end,
		})
	end,
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			opts = {},
		},
	},
}
