-- ============================================================================
-- 🪶 Conform.nvim - Otomatik Formatter Yönetimi
-- ============================================================================
local ok, conform = pcall(require, "conform")
if not ok then
	vim.notify("⚠️ conform.nvim yüklenemedi", vim.log.levels.ERROR)
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "eslint_d", "prettier" },
		typescript = { "prettierd", "eslint_d", "prettier" },
		javascriptreact = { "prettierd", "eslint_d" },
		typescriptreact = { "prettierd", "eslint_d" },
		json = { "prettierd", "jq" },
		html = { "prettierd" },
		css = { "prettierd" },
		markdown = { "prettierd" },
	},

	format_on_save = function(bufnr)
		local ft = vim.bo[bufnr].filetype
		if ft == "javascript" or ft == "typescript" or ft == "typescriptreact" or ft == "javascriptreact" then
			return { timeout_ms = 2000, lsp_fallback = true }
		end
		return { timeout_ms = 2000, lsp_fallback = true }
	end,
})

-- Manuel format tuşu
vim.keymap.set("n", "<leader>cf", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer with Conform" })

vim.notify("✅ Conform formatters yüklendi (prettierd, eslint_d, stylua, jq)", vim.log.levels.INFO)
