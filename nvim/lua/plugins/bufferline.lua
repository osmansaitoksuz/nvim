require("bufferline").setup({
	options = {
		mode = "buffers", -- "tabs" is also possible
		themable = true,
		numbers = "none",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator = {
			icon = "▎",
			style = "icon",
		},
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 25,
		max_prefix_length = 15,
		tab_size = 20,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "📁 File Explorer",
				text_align = "left",
				separator = true,
			},
			{
				filetype = "nerdtree",
				text = "📁 File Explorer",
				text_align = "left",
				separator = true,
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "slant",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		sort_by = "insert_after_current",
		highlights = {
			fill = { bg = "#282c34" },
			background = { bg = "#282c34" },
			buffer_selected = { bg = "#3c4048", fg = "#ffffff", bold = true },
			buffer_visible = { bg = "#282c34", fg = "#b6bd68" },
			separator = { fg = "#1d1f21", bg = "#282c34" },
			separator_selected = { fg = "#3c4048", bg = "#3c4048" },
			modified = { fg = "#cc6566", bg = "#282c34" },
			modified_selected = { fg = "#cc6566", bg = "#3c4048" },
			diagnostic = { fg = "#b6bd68" },
		},
	},
})
