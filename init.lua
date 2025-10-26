package.path = package.path .. ";/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua"
package.cpath = package.cpath .. ";/usr/lib/lua/5.4/?.so"

require("core.options")
require("core.keymaps")
require("core.lazy")
require("plugins.lualine")
require("core.colors").setup()

-- sadece modern LSP modüllerini yükle
require("lsp.typescript")

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
