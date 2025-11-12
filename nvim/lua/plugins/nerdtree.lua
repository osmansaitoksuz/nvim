-- lua/plugins/nerdtree.lua
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrowExpandable = "▸"
vim.g.NERDTreeDirArrowCollapsible = "▾"

-- Otomatik açılmasın
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("NERDTree")
		end
	end,
})

-- Kısayol
vim.keymap.set("n", "<leader>n", ":NERDTreeToggle<CR>", { desc = "Toggle NERDTree" })
