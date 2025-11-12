-- Mason & tool installer setup
return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup({
			ui = { border = "rounded" },
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"eslint",
				"lua_ls",
				"jsonls",
				"html",
				"pyright",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"typescript-language-server",
				"eslint-lsp",
				"json-lsp",
				"lua-language-server",
				"pyright",
				"prettierd",
				"prettier",
				"eslint_d",
				"stylua",
				"jq",
				"html-lsp",
				"htmlhint",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
