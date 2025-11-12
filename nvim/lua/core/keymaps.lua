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
-- keymap("n", "<leader>f", function()
-- 	vim.lsp.buf.format({ async = true })
-- end, { desc = "Format buffer" })
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

-- =============================================================================
-- 📜 METİN / DÜZENLEME
-- =============================================================================
-- Yorum satırları (comment.nvim veya vim-commentary benzeriyle uyumlu)
keymap("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
keymap("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment (visual)" })
-- =============================================================================
-- 🧠 YARDIMCI / MISC
-- =============================================================================
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>r", ":edit!<CR>", { desc = "Reload buffer" })
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

-- Buffer kontrolü
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "Sonraki buffer" })
keymap("n", "<leader>bp", ":bprevious<CR>", { desc = "Önceki buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Buffer'ı kapat" })

-- 🧱 Toplu tab / shift-tab (indentation)
-- Normal modda sekme ekleme
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })

-- Visual modda seçili satırları girintileme
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- =============================================================================
-- 🔧 GIT SIGNS
-- =============================================================================
-- keymap("n", "]c", function()
-- 	local ok, gs = pcall(require, "gitsigns")
-- 	if not ok then
-- 		return
-- 	end
-- 	if vim.wo.diff then
-- 		return "]c"
-- 	end
-- 	gs.next_hunk()
-- end, { desc = "Next Git hunk" })
--
-- keymap("n", "[c", function()
-- 	local ok, gs = pcall(require, "gitsigns")
-- 	if not ok then
-- 		return
-- 	end
-- 	if vim.wo.diff then
-- 		return "[c"
-- 	end
-- 	gs.prev_hunk()
-- end, { desc = "Previous Git hunk" })
--
-- keymap("n", "<leader>hs", function()
-- 	local ok, gs = pcall(require, "gitsigns")
-- 	if ok then
-- 		gs.stage_hunk()
-- 	end
-- end, { desc = "Stage hunk" })
--
-- keymap("n", "<leader>hr", function()
-- 	local ok, gs = pcall(require, "gitsigns")
-- 	if ok then
-- 		gs.reset_hunk()
-- 	end
-- end, { desc = "Reset hunk" })
--
-- keymap("n", "<leader>hp", function()
-- 	local ok, gs = pcall(require, "gitsigns")
-- 	if ok then
-- 		gs.preview_hunk()
-- 	end
-- end, { desc = "Preview hunk" })
--
-- keymap("n", "<leader>hb", function()
-- 	local ok, gs = pcall(require, "gitsigns")
-- 	if ok then
-- 		gs.blame_line({ full = true })
-- 	end
-- end, { desc = "Blame current line" })

-- =============================================================================
-- 🧹 FORMAT / CONFORM
-- =============================================================================
