-- lua/plugins/lsp.lua
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()

mason_lspconfig.setup({
  ensure_installed = { 'ts_ls', 'lua_ls', 'pyright', 'eslint', 'jsonls' },
  automatic_installation = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
  map('n', 'gr', vim.lsp.buf.references, 'List references')
  map('n', 'K', vim.lsp.buf.hover, 'Hover info')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
  map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
  map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format')
end

-- TypeScript / JavaScript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    javascript = { suggest = { autoImports = true } },
    typescript = { suggest = { autoImports = true }, inlayHints = { includeInlayParameterNameHints = 'all' } },
  },
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ESLint
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', { buffer = bufnr, command = 'EslintFixAll' })
  end,
})