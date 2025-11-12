-- Genel Neovim ayarları
local opt = vim.opt

--terminal renkleri kullanımı için
-- Renkleri terminalden al
-- Terminal renklerini devral
opt.number = true -- Satır numaraları
opt.relativenumber = true -- Göreceli numaralar
opt.mouse = "a" -- Fare desteği
opt.clipboard = "unnamedplus" -- Sistem panosu ile paylaşım
opt.tabstop = 4 -- Tab genişliği
opt.shiftwidth = 4
opt.expandtab = true -- Tab yerine boşluk
opt.termguicolors = true -- Gerçek renk desteği
opt.wrap = false -- Satır taşmasını kapat
opt.cursorline = true -- İmleç satırını vurgula
opt.scrolloff = 8 -- Kenarlardan boşluk bırak
opt.termguicolors = true

opt.laststatus = 3 -- Lualine'ı göstermek için şart!
opt.showmode = false -- zaten Lualine gösteriyor
