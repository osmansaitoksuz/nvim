local ok, conform = pcall(require, 'conform')
if not ok then
  vim.notify('conform.nvim yüklenemedi', vim.log.levels.ERROR)
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd', 'eslint_d', 'prettier' },
    typescript = { 'prettierd', 'eslint_d', 'prettier' },
    javascriptreact = { 'prettierd', 'eslint_d' },
    typescriptreact = { 'prettierd', 'eslint_d' },
    json = { 'prettierd', 'jq' },
    html = { 'prettierd' },
    css  = { 'prettierd' },
    markdown = { 'prettierd' },
    python = { 'ruff_format', 'isort', 'black' },
  },
  format_on_save = function(bufnr)
    return { timeout_ms = 2000, lsp_fallback = true }
  end,
})

vim.keymap.set('n', '<leader>cf', function() conform.format({ async = true, lsp_fallback = true }) end, { desc = 'Format buffer with Conform' })