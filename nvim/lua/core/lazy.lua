-- lazy.nvim kurulum ve plugin listesi
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.mason"),
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "numToStr/Comment.nvim", config = true }, -- yorum satırı kısayolları (gcc, gc)
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} }, -- LSP hataları için panel
	{ "onsails/lspkind.nvim" }, -- cmp menüsüne ikonlar
	{ "windwp/nvim-autopairs", config = true }, -- otomatik parantez kapatma
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("plugins.cmp")
		end,
	},
	-- {
	-- 	{
	-- 		"williamboman/mason.nvim",
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 	},
	-- },
	{ "preservim/nerdtree" },
	{ "Xuyuanp/nerdtree-git-plugin" }, -- Git durum simgeleri
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = require("plugins.oil"),
	},
	{ "christoomey/vim-tmux-navigator" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	}, --	{ "folke/tokyonight.nvim" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "echasnovski/mini.surround", version = "*" },
	{ "Shatur/neovim-ayu" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
			})
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{ "sitiom/nvim-numbertoggle" },
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("plugins.lint")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("plugins.format")
		end,
	},
}, {
	rocks = { enabled = false },
})
