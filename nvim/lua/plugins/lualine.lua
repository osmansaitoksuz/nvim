local palette = {
	accent = "#82a2be",
	insert = "#b6bd68",
	visual = "#cc6566",
	replace = "#f0c674",
	command = "#7aa6da",
	dim = "#6c7079",
	inactive = "#666666",
	diag_error = "#f44747",
	diag_warn = "#ffaf00",
	diag_info = "#82a2be",
	diag_hint = "#6cbfbf",
	diff_add = "#8cbe7a",
	diff_change = "#7aa6da",
	diff_delete = "#cc6666",
	mode_normal = "#3b414d",
	mode_insert = "#4a5336",
	mode_visual = "#553742",
	mode_replace = "#4f432e",
	mode_command = "#2f4758",
}

local BUFFER_WIDTH = 18

local function hex_or_none(value)
	if value == nil then
		return "none"
	end
	if type(value) == "number" then
		return string.format("#%06x", value)
	end
	return value
end

local function get_hl_color(group, attr)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if not ok then
		ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
		if ok and attr == "fg" then
			hl = { fg = hl.foreground }
		elseif ok and attr == "bg" then
			hl = { bg = hl.background }
		end
	end
	if not ok or not hl then
		return nil
	end
	return hex_or_none(hl[attr])
end

local function build_theme(normal_bg, normal_fg)
	local resolved_bg = normal_bg ~= "none" and normal_bg or "#1d1f21"
	local resolved_fg = normal_fg ~= "none" and normal_fg or "#c4c8c6"
	return {
		normal = {
			a = { fg = resolved_fg, bg = palette.mode_normal, gui = "bold" },
			b = { fg = resolved_fg, bg = resolved_bg },
			c = { fg = resolved_fg, bg = resolved_bg },
		},
		insert = { a = { fg = resolved_fg, bg = palette.mode_insert, gui = "bold" } },
		visual = { a = { fg = resolved_fg, bg = palette.mode_visual, gui = "bold" } },
		replace = { a = { fg = resolved_fg, bg = palette.mode_replace, gui = "bold" } },
		command = { a = { fg = resolved_fg, bg = palette.mode_command, gui = "bold" } },
		inactive = {
			a = { fg = palette.inactive, bg = resolved_bg },
			b = { fg = palette.inactive, bg = resolved_bg },
			c = { fg = palette.inactive, bg = resolved_bg },
		},
	}
end

local function resolved_bg(bg)
	if not bg or bg == "none" then
		return "none"
	end
	return bg
end

local function diagnostic_colors(bg)
	local resolved = resolved_bg(bg)
	return {
		error = { fg = get_hl_color("DiagnosticError", "fg") or palette.diag_error, bg = resolved },
		warn = { fg = get_hl_color("DiagnosticWarn", "fg") or palette.diag_warn, bg = resolved },
		info = { fg = get_hl_color("DiagnosticInfo", "fg") or palette.diag_info, bg = resolved },
		hint = { fg = get_hl_color("DiagnosticHint", "fg") or palette.diag_hint, bg = resolved },
	}
end

local function diff_colors(bg)
	local resolved = resolved_bg(bg)
	return {
		added = { fg = get_hl_color("DiffAdd", "fg") or palette.diff_add, bg = resolved },
		modified = { fg = get_hl_color("DiffChange", "fg") or palette.diff_change, bg = resolved },
		removed = { fg = get_hl_color("DiffDelete", "fg") or palette.diff_delete, bg = resolved },
	}
end

local function setup_lualine()
	local normal_bg = get_hl_color("Normal", "bg") or "#1d1f21"
	local normal_fg = get_hl_color("Normal", "fg") or "#c4c8c6"
	local theme = build_theme(normal_bg, normal_fg)
	local statusline_bg = resolved_bg(normal_bg)
	local filetype_color = {
		fg = get_hl_color("Type", "fg") or normal_fg,
		bg = statusline_bg ~= "none" and statusline_bg or nil,
	}
	local diagnostics_color = diagnostic_colors(statusline_bg)
	local diff_color = diff_colors(statusline_bg)

	require("lualine").setup({
		options = {
			theme = theme,
			icons_enabled = true,
			component_separators = { left = "│", right = "│" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
			always_divide_middle = true,
			disabled_filetypes = {},
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return str:upper()
					end,
				},
			},
			lualine_b = {
				{ "branch", icon = "" },
				{
					"diff",
					symbols = { added = " ", modified = "󰝤 ", removed = " " },
					diff_color = diff_color,
					colored = true,
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
					diagnostics_color = diagnostics_color,
					colored = true,
				},
			},
			lualine_c = {
				{
					"buffers",
					mode = 2,
					show_filename_only = true,
					symbols = { alternate_file = "", modified = "●" },
					fmt = function(name)
						local display_name = vim.fn.fnamemodify(name, ":t")
						local width = vim.fn.strdisplaywidth(display_name)
						if width > BUFFER_WIDTH then
							display_name = vim.fn.strcharpart(display_name, 0, BUFFER_WIDTH - 1) .. "…"
							width = vim.fn.strdisplaywidth(display_name)
						end
						if width < BUFFER_WIDTH then
							display_name = display_name .. string.rep(" ", BUFFER_WIDTH - width)
						end
						return display_name
					end,
					buffers_color = {
						active = {
							fg = normal_bg ~= "none" and normal_bg or "#1d1f21",
							bg = palette.accent,
							gui = "bold",
						},
						inactive = { fg = palette.dim, bg = statusline_bg ~= "none" and statusline_bg or nil },
					},
				},
			},
			lualine_x = {
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					end,
					icon = "",
					color = { fg = normal_fg, bg = statusline_bg ~= "none" and statusline_bg or nil },
				},
			},
			lualine_y = {
				{
					"filetype",
					icon_only = false,
					color = filetype_color,
				},
			},
			lualine_z = {
				{
					"location",
					color = { fg = palette.command, bg = statusline_bg ~= "none" and statusline_bg or nil },
				},
				{
					"progress",
					color = { fg = normal_fg, bg = statusline_bg ~= "none" and statusline_bg or nil },
				},
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					color = { fg = palette.inactive, bg = statusline_bg ~= "none" and statusline_bg or nil },
				},
			},
			lualine_x = {
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					end,
					icon = "",
					color = { fg = palette.inactive, bg = statusline_bg ~= "none" and statusline_bg or nil },
				},
			},
			lualine_y = {},
			lualine_z = {
				{
					"location",
					color = { fg = palette.inactive, bg = statusline_bg ~= "none" and statusline_bg or nil },
				},
			},
		},
		extensions = { "nvim-tree", "nerdtree", "fugitive" },
	})

	local statusline_hl = {
		fg = normal_fg ~= "none" and normal_fg or nil,
		bg = statusline_bg ~= "none" and statusline_bg or nil,
	}

	vim.api.nvim_set_hl(0, "StatusLine", statusline_hl)
	vim.api.nvim_set_hl(0, "StatusLineNC", vim.tbl_extend("force", statusline_hl, { fg = palette.inactive }))
end

local lualine_theme_group = vim.api.nvim_create_augroup("LualineDynamicTheme", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	group = lualine_theme_group,
	callback = function()
		vim.schedule(setup_lualine)
	end,
})

if vim.v.vim_did_enter == 1 then
	vim.schedule(setup_lualine)
end

vim.api.nvim_create_user_command("LualineReload", function()
	vim.schedule(setup_lualine)
end, { desc = "Reapply lualine configuration" })
