-- Modern Neovim 0.11+ LSP setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 🔹 Ortak on_attach fonksiyonu
local function on_attach(_, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
	end
	map("n", "gd", vim.lsp.buf.definition, "Go to definition")
	map("n", "gr", vim.lsp.buf.references, "List references")
	map("n", "K", vim.lsp.buf.hover, "Hover info")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, "Format buffer")
end

-- 🟦 TypeScript / JavaScript
vim.lsp.config.ts_ls = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_dir = vim.fs.root(0, { "tsconfig.json", "package.json", ".git" }),
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		typescript = { format = { enable = false } },
		javascript = { format = { enable = false } },
	},
}

-- 🟨 ESLint
vim.lsp.config.eslint = {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
	root_dir = vim.fs.root(0, { ".eslintrc", ".eslintrc.js", "package.json", ".git" }),
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		codeActionOnSave = { enable = true, mode = "all" },
		format = true,
		experimental = { useFlatConfig = true },
	},
}

-- 🧩 Lua
vim.lsp.config.lua_ls = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = vim.fs.root(0, { ".luarc.json", ".git" }),
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- 🧱 JSON
vim.lsp.config.jsonls = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_dir = vim.fs.root(0, { ".git" }),
	capabilities = capabilities,
	on_attach = on_attach,
}

-- 🚀 Otomatik başlatma
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local config = vim.lsp.config[args.match]
		if config then
			vim.lsp.start(config)
		end
	end,
})
