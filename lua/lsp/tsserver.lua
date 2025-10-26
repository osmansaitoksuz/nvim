local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(_, bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	end,
	settings = {
		completions = { completeFunctionCalls = true },
	},
})
