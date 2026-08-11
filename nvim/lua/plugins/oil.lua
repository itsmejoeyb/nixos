return {
	"stevearc/oil.nvim",
	lazy = false,
	opts = {
		default_file_explorer = true,
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	keys = {
		{ "<leader>e", "<cmd>Oil<CR>", desc = "Open parent directory" },
	},
}
