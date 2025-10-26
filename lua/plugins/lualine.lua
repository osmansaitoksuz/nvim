-- 🎨 "Deus-style" Lualine (Ghostty uyumlu, sade, #282c34 arka planlı)
local custom_deus = {
	normal = {
		a = { fg = "#1d1f21", bg = "#82a2be", gui = "bold" },
		b = { fg = "#c4c8c6", bg = "#282c34" },
		c = { fg = "#eaeaea", bg = "#282c34" },
	},
	insert = { a = { fg = "#1d1f21", bg = "#b6bd68", gui = "bold" } },
	visual = { a = { fg = "#1d1f21", bg = "#cc6566", gui = "bold" } },
	replace = { a = { fg = "#1d1f21", bg = "#f0c674", gui = "bold" } },
	command = { a = { fg = "#1d1f21", bg = "#7aa6da", gui = "bold" } },
	inactive = {
		a = { fg = "#666666", bg = "#282c34" },
		b = { fg = "#666666", bg = "#282c34" },
		c = { fg = "#666666", bg = "#282c34" },
	},
}

require("lualine").setup({
	options = {
		theme = custom_deus,
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		always_divide_middle = true,
		disabled_filetypes = {},
	},

	sections = {
		lualine_a = { { "mode", upper = true } },
		lualine_b = {
			{ "branch", icon = "" },
			{
				"diff",
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
			},
		},
		lualine_c = {
			{
				"filename",
				path = 1,
				symbols = { modified = "●", readonly = "" },
			},
			{
				function()
					return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				end,
				icon = "",
				color = { fg = "#87afaf" },
			},
		},
		lualine_x = {
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if next(clients) == nil then
						return ""
					end
					local names = {}
					for _, client in pairs(clients) do
						table.insert(names, client.name)
					end
					return " " .. table.concat(names, ", ")
				end,
				color = { fg = "#b6bd68" },
			},
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = {
			{
				function()
					return " " .. os.date("%H:%M")
				end,
				color = { fg = "#1d1f21", gui = "bold" },
			},
		},
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},

	-- 🧭 Tab ve Buffer görünümü (#282c34 arka planlı)
	tabline = {
		lualine_a = {
			{
				"tabs",
				tab_max_length = 25,
				mode = 2,
				separator = { left = "", right = "" },
				color = { bg = "#282c34", fg = "#c4c8c6" },
			},
		},
		lualine_b = {
			{
				"buffers",
				show_filename_only = true,
				mode = 2,
				buffers_color = {
					active = { bg = "#282c34", fg = "#ffffff" },
					inactive = { bg = "#282c34", fg = "#888888" },
				},
			},
		},
		-- hostname kaldırıldı
	},

	extensions = { "nvim-tree", "nerdtree", "fugitive" },
})

-- terminal ve nvim arka planını eşitleyelim
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("hi Normal guibg=#1d1f21 guifg=#c4c8c6")
vim.cmd("hi StatusLine guibg=#282c34")
vim.cmd("hi TabLine guibg=#282c34")
vim.cmd("hi TabLineFill guibg=#282c34")
vim.cmd("hi TabLineSel guibg=#282c34 gui=bold")
