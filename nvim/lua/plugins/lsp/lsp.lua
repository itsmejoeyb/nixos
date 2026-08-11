return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		local function set_typescript_sdk(_, config)
			local util = require("lspconfig.util")
			local tsdk = util.get_typescript_server_path(config.root_dir)

			if not tsdk or tsdk == "" then
				tsdk = vim.fs.joinpath(
					vim.fn.stdpath("data"),
					"mason",
					"packages",
					"typescript-language-server",
					"node_modules",
					"typescript",
					"lib"
				)
			end

			config.init_options = config.init_options or {}
			config.init_options.typescript = config.init_options.typescript or {}
			config.init_options.typescript.tsdk = tsdk
		end

		for _, server in ipairs({ "astro", "mdx_analyzer" }) do
			vim.lsp.config(server, {
				before_init = set_typescript_sdk,
			})
		end
	end,
}
