-- lua/core/keymaps.lua
-- 🔑 Global keymaps for Neovim setup
-- =============================================================================
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =============================================================================
-- 🌐 GENEL
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Kaydet / Çık / Pencere kontrolleri
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
-- keymap("n", "<leader>x", ":x<CR>", { desc = "Save and exit" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all (force)" })

-- Pencere navigasyonu
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Terminalden çık
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- =============================================================================
-- 🗂️ DOSYA GEZİNME: NERDTree & Oil
-- =============================================================================
keymap("n", "<C-n>", ":NERDTreeToggle<CR>", { desc = "Toggle NERDTree" })
keymap("n", "<leader>n", ":NERDTreeFind<CR>", { desc = "Find current file in NERDTree" })
keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory (Oil)" })

-- =============================================================================
-- 🔍 TELESCOPE
-- =============================================================================
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
keymap("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "LSP symbols" })

-- =============================================================================
-- ⚙️ LSP / DİL SERVİSLERİ
-- =============================================================================
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "List references" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
keymap("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP Info" })

-- Diagnostikler
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix diagnostics" })

-- =============================================================================
-- 💡 TAMAMLAMA (nvim-cmp)
-- =============================================================================
keymap("i", "<C-Space>", function()
	require("cmp").complete()
end, { desc = "Trigger completion menu" })
keymap("i", "<C-e>", function()
	require("cmp").abort()
end, { desc = "Abort completion" })

-- =============================================================================
-- 🔧 GIT SIGNS
-- =============================================================================
keymap("n", "]c", function()
	local ok, gs = pcall(require, "gitsigns")
	if not ok then
		return
	end
	if vim.wo.diff then
		return "]c"
	end
	gs.next_hunk()
end, { desc = "Next Git hunk" })

keymap("n", "[c", function()
	local ok, gs = pcall(require, "gitsigns")
	if not ok then
		return
	end
	if vim.wo.diff then
		return "[c"
	end
	gs.prev_hunk()
end, { desc = "Previous Git hunk" })

keymap("n", "<leader>hs", function()
	local ok, gs = pcall(require, "gitsigns")
	if ok then
		gs.stage_hunk()
	end
end, { desc = "Stage hunk" })

keymap("n", "<leader>hr", function()
	local ok, gs = pcall(require, "gitsigns")
	if ok then
		gs.reset_hunk()
	end
end, { desc = "Reset hunk" })

keymap("n", "<leader>hp", function()
	local ok, gs = pcall(require, "gitsigns")
	if ok then
		gs.preview_hunk()
	end
end, { desc = "Preview hunk" })

keymap("n", "<leader>hb", function()
	local ok, gs = pcall(require, "gitsigns")
	if ok then
		gs.blame_line({ full = true })
	end
end, { desc = "Blame current line" })

-- =============================================================================
-- 🧹 FORMAT / CONFORM
-- =============================================================================
keymap("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format with Conform" })

-- =============================================================================
-- 🌈 GÖRSEL / ARAYÜZ
-- =============================================================================
keymap("n", "<leader>td", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end, { desc = "Toggle dark/light mode" })

-- keymap("n", "<leader>th", function()
-- 	vim.cmd("colorscheme ayu-mirage")
-- end, { desc = "Set theme: ayu-mirage" })

-- keymap("n", "<leader>tl", function()
-- 	vim.cmd("colorscheme onedark")
-- end, { desc = "Set theme: onedark" })

keymap("n", "<leader>rl", "<cmd>LualineReload<CR>", { desc = "Reload Lualine" })

-- =============================================================================
-- 📜 METİN / DÜZENLEME
-- =============================================================================
-- Yorum satırları (comment.nvim veya vim-commentary benzeriyle uyumlu)
keymap("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
keymap("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment (visual)" })

-- Kopyalama ve yapıştırma
keymap("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- =============================================================================
-- 🌳 TREESITTER
-- =============================================================================
keymap("n", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>", { desc = "Toggle TS playground" })

-- =============================================================================
-- 🔢 GÖRSEL DETAY / NUMARA TOGGLE
-- =============================================================================
keymap("n", "<leader>ln", ":set relativenumber!<CR>", { desc = "Toggle relative numbers" })

-- =============================================================================
-- 🧠 YARDIMCI / MISC
-- =============================================================================
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>r", ":edit!<CR>", { desc = "Reload buffer" })
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

-- CTRL + h/l: NERDTree ↔ Editör arasında geçiş
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Tab kontrolü
keymap("n", "<leader>tn", ":tabnew<CR>", { desc = "Yeni tab aç" })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Geçerli tab'ı kapat" })
keymap("n", "<leader>to", ":tabonly<CR>", { desc = "Diğer tabları kapat" })
keymap("n", "<leader>tl", "gt", { desc = "Sonraki tab" })
keymap("n", "<leader>th", "gT", { desc = "Önceki tab" })

-- Buffer kontrolü
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "Sonraki buffer" })
keymap("n", "<leader>bp", ":bprevious<CR>", { desc = "Önceki buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Buffer'ı kapat" })

-- Buffer navigasyonu
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Sonraki buffer" })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Önceki buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true, desc = "Buffer kapat" })
vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { silent = true, desc = "Diğer buffer'ları kapat" })

-- 🧱 Toplu tab / shift-tab (indentation)
-- Normal modda sekme ekleme
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })

-- Visual modda seçili satırları girintileme
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- keymap("n", "?", function()
-- 	require("core.keymap_helper").show_keymaps()
-- end, { desc = "Show keymaps" })

-- =============================================================================
-- ❓ Keymap Yardım Penceresi
-- =============================================================================

local function show_keymaps()
	local buf = vim.api.nvim_create_buf(false, true)
	local mappings = vim.api.nvim_get_keymap("n")

	local lines = {
		"🧭 Neovim Keymap Rehberi",
		"─────────────────────────────",
		"",
	}

	local function prettify_keys(lhs)
		return lhs:gsub("<C%-", "Ctrl+"):gsub("<S%-", "Shift+"):gsub("<A%-", "Alt+"):gsub("<leader>", "␣") -- boşluk tuşu
	end

	for _, map in ipairs(mappings) do
		if map.desc then
			table.insert(lines, string.format("%-20s → %s", prettify_keys(map.lhs), map.desc))
		end
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	local width = 60
	local height = math.min(#lines + 2, 40)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
end

-- “?” tuşuna basınca çalışsın
vim.keymap.set("n", "?", show_keymaps, { noremap = true, silent = true, desc = "Keymap rehberi göster" })
