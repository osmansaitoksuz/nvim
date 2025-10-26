-- Mason & tool installer setup
return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
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
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"typescript-language-server",
				"vscode-eslint-language-server",
				"vscode-json-language-server",
				"lua-language-server",
				"prettierd",
				"eslint_d",
				"stylua",
				"jq",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
