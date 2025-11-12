local M = {}

local function apply_highlights()
	vim.g.terminal_ansi_colors = {
		"#1d1f21",
		"#cc6566",
		"#b6bd68",
		"#f0c674",
		"#82a2be",
		"#b294bb",
		"#8abeb7",
		"#c4c8c6",
		"#666666",
		"#d54e53",
		"#b9ca4b",
		"#e7c547",
		"#7aa6da",
		"#c397d8",
		"#70c0b1",
		"#eaeaea",
	}

	local none_bg = { bg = "none", fg = "none" }
	vim.api.nvim_set_hl(0, "Normal", none_bg)
	vim.api.nvim_set_hl(0, "NormalNC", none_bg)
	vim.api.nvim_set_hl(0, "NormalFloat", none_bg)
	vim.api.nvim_set_hl(0, "SignColumn", none_bg)

	vim.api.nvim_set_hl(0, "Constant", { fg = "#b9ca4b" })
	vim.api.nvim_set_hl(0, "String", { fg = "#b6bd68" })
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#82a2be" })
	vim.api.nvim_set_hl(0, "Statement", { fg = "#cc6566" })
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#b294bb" })
	vim.api.nvim_set_hl(0, "Type", { fg = "#70c0b1" })
	vim.api.nvim_set_hl(0, "Special", { fg = "#e7c547" })
	vim.api.nvim_set_hl(0, "Underlined", { fg = "#7aa6da", underline = true })
	vim.api.nvim_set_hl(0, "Todo", { fg = "#f0c674", bold = true })

	local gray_dim = "#666666"
	local gray_mid = "#8a8f95"
	local gray_ui = "#9aa0a6"

	vim.api.nvim_set_hl(0, "Comment", { fg = gray_mid, italic = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = gray_mid })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = gray_dim })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = gray_dim })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f0c674", bold = true })

	vim.api.nvim_set_hl(0, "FoldColumn", { fg = gray_ui, bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#353a44" })
	vim.api.nvim_set_hl(0, "NonText", { fg = "#353a44" })

	vim.cmd([[
highlight! Pmenu guibg=#282c34 guifg=#c4c8c6
highlight! PmenuSel guibg=#3c4048 guifg=#ffffff
highlight! CmpItemAbbrMatch guifg=#82a2be gui=bold
highlight! CmpItemKindFunction guifg=#b6bd68
highlight! CmpItemKindVariable guifg=#f0c674
highlight! CmpItemKindClass guifg=#cc6566
]])
end

function M.setup()
	vim.opt.termguicolors = true
	vim.opt.background = "dark"

	local ok, ayu = pcall(require, "ayu")
	if ok then
		ayu.setup({
			mirage = true,
			terminal = true,
		})
		ayu.colorscheme()
	end

	apply_highlights()
end

return M
