-- Airline ayarları
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1

-- Önce renk şemasını uygula
vim.cmd("colorscheme deus")

-- Ardından airline temasını eşleştir
vim.g.airline_theme = "deus"
vim.cmd([[
  augroup AirlineColors
    autocmd!
    autocmd ColorScheme * highlight AirlineWarning guifg=#cc6566 guibg=#353a44
    autocmd ColorScheme * highlight AirlineError guifg=#cc6566 guibg=#353a44
    autocmd ColorScheme * highlight AirlineTerm guifg=#b294bb guibg=#353a44
  augroup END
]])
