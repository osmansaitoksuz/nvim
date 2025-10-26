-- Syntax highlight ve kod analizi
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "vimdoc" },
	highlight = { enable = true },
	indent = { enable = true },
})
