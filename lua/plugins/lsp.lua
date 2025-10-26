local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- Mason kurulum
mason.setup()
mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls", -- typescript-language-server
		"pyright",
	},
	automatic_installation = true,
})

-- LSP özellikleri
local on_attach = function(_, bufnr)
	local bufmap = function(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
	end

	bufmap("n", "gd", vim.lsp.buf.definition)
	bufmap("n", "gr", vim.lsp.buf.references)
	bufmap("n", "K", vim.lsp.buf.hover)
	bufmap("n", "<leader>rn", vim.lsp.buf.rename)
	bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
	bufmap("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- TypeScript
lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		javascript = {
			suggest = { autoImports = true },
		},
		typescript = {
			suggest = { autoImports = true },
			inlayHints = { includeInlayParameterNameHints = "all" },
		},
	},
})

-- Lua (Neovim)
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})
