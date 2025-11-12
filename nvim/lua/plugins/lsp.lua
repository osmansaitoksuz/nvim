local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
	ui = { border = "rounded" },
	PATH = "append",
})

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"eslint",
		"html",
		"jsonls",
		"pyright",
	},
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function map_on_attach(bufnr)
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

local function default_on_attach(client, bufnr)
	map_on_attach(bufnr)
	if client.name == "ts_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end
end

local function root_pattern(...)
	local patterns = { ... }
	return function(filename, bufnr)
		if bufnr ~= nil then
			if type(bufnr) ~= "number" or bufnr <= 0 or not vim.api.nvim_buf_is_valid(bufnr) then
				return vim.loop.cwd()
			end
			filename = vim.api.nvim_buf_get_name(bufnr)
		end

		if filename == nil or filename == "" then
			filename = vim.api.nvim_buf_get_name(0)
		end

		if filename == nil or filename == "" then
			return vim.loop.cwd()
		end

		local dirname = vim.fs.dirname(filename)
		if dirname == nil or dirname == "" then
			dirname = vim.loop.cwd()
		end

		local found = vim.fs.find(patterns, { path = dirname, upward = true, stop = vim.loop.os_homedir() })
		if type(found) == "table" and #found > 0 then
			return vim.fs.dirname(found[1])
		end

		return vim.loop.cwd()
	end
end

vim.lsp.config = vim.lsp.config or {}

local function register_lsp(name, config)
	local final = vim.tbl_deep_extend("force", {
		name = name,
		capabilities = capabilities,
		on_attach = default_on_attach,
	}, config)

	vim.lsp.config[name] = final
	vim.lsp.enable(name)
end

register_lsp("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", ".git"),
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

register_lsp("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "htmldjango" },
	root_dir = root_pattern("package.json", ".git"),
	init_options = { provideFormatter = true },
})

register_lsp("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = root_pattern(
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		".git"
	),
})

register_lsp("jsonls", {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_dir = root_pattern(".git"),
})

register_lsp("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_dir = root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
})

register_lsp("eslint", {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
	root_dir = root_pattern(
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		"package.json",
		".git"
	),
	settings = {
		codeActionOnSave = { enable = true, mode = "all" },
		format = true,
	},
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local notified = {}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("custom_lsp_notifications", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local ft = vim.bo[args.buf].filetype or "unknown"
		local key = client.name .. ":" .. ft

		if not notified[key] then
			notified[key] = true
			vim.notify(string.format("LSP attached: %s (%s)", client.name, ft), vim.log.levels.INFO, {
				title = "LSP",
			})
		end
	end,
})
