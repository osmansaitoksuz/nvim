-- ============================================================================
-- 🪶 Conform.nvim - Otomatik Formatter Yönetimi
-- ============================================================================
local ok, conform = pcall(require, "conform")
if not ok then
	vim.notify("⚠️ conform.nvim yüklenemedi", vim.log.levels.ERROR)
	return
end

local function available_formatters(...)
	local names = { ... }
	local result = {}
	for _, name in ipairs(names) do
		if vim.fn.executable(name) == 1 then
			table.insert(result, name)
		end
	end
	return result
end

local function add_formatters(target, filetype, ...)
	local list = available_formatters(...)
	if #list > 0 then
		target[filetype] = list
	end
end

local formatters_by_ft = {}
add_formatters(formatters_by_ft, "lua", "stylua")
add_formatters(formatters_by_ft, "javascript", "prettierd", "eslint_d", "prettier")
add_formatters(formatters_by_ft, "typescript", "prettierd", "eslint_d", "prettier")
add_formatters(formatters_by_ft, "javascriptreact", "prettierd", "eslint_d", "prettier")
add_formatters(formatters_by_ft, "typescriptreact", "prettierd", "eslint_d", "prettier")
add_formatters(formatters_by_ft, "json", "prettierd", "jq", "prettier")
add_formatters(formatters_by_ft, "html", "prettierd", "prettier")
add_formatters(formatters_by_ft, "css", "prettierd", "prettier")
add_formatters(formatters_by_ft, "markdown", "prettierd", "prettier")

conform.setup({
	formatters_by_ft = formatters_by_ft,
	notify_on_error = false,
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
