-- lua/core/colors.lua
local M = {}

function M.setup()
	-- önce ayarları yap

	function M.setup()
		-- Gerçek renk desteğini aç
		vim.opt.termguicolors = true
		vim.opt.background = "dark"

		require("ayu").setup({
			mirage = true, -- dark versiyon
			terminal = true, -- terminal paletini de kullan
		})

		-- sonra temayı uygula
		require("ayu").colorscheme()
	end

	-- Ghostty / WezTerm paletini doğrudan belirt
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

	-- Arka plan terminalden gelsin
	local none = { bg = "none", fg = "none" }
	vim.api.nvim_set_hl(0, "Normal", none)
	vim.api.nvim_set_hl(0, "NormalNC", none)
	vim.api.nvim_set_hl(0, "NormalFloat", none)
	vim.api.nvim_set_hl(0, "SignColumn", none)

	-- Klasik highlight gruplarını Ghostty paletine göre ayarla
	vim.api.nvim_set_hl(0, "Comment", { fg = "#666666", italic = true })
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
	local gray_mid = "#8a8f95" -- daha belirgin ama yumuşak
	local gray_ui = "#9aa0a6"

	-- Yorumlar: bir tık aç + italic kalsın (istersen italic=false yapabilirsin)
	vim.api.nvim_set_hl(0, "Comment", { fg = gray_mid, italic = true })

	-- Satır numaraları
	vim.api.nvim_set_hl(0, "LineNr", { fg = gray_mid })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = gray_dim })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = gray_dim })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f0c674", bold = true })

	-- Kenar/UI çizgileri biraz daha belirgin
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

return M
