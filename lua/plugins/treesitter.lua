require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'lua', 'vim', 'vimdoc',
    'javascript', 'typescript', 'tsx',
    'python', 'json', 'html', 'css', 'bash', 'markdown', 'markdown_inline', 'regex'
  },
  highlight = { enable = true },
  indent = { enable = true },
})