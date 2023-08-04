-- settings independent from plugins

local spaces_for_indent = 4

lvim.keys.normal_mode["<tab>"] = "<ESC>:bn<CR>"
lvim.keys.normal_mode["<S-tab>"] = "<ESC>:bp<CR>"
lvim.keys.normal_mode["\\d"] = "<ESC>:bd<CR>"

lvim.keys.normal_mode["_"] = "<ESC>:res -1<CR>"
lvim.keys.normal_mode["+"] = "<ESC>:res +1<CR>"
lvim.keys.normal_mode["-"] = "<ESC><C-W><"
lvim.keys.normal_mode["="] = "<ESC><C-W>>"

lvim.keys.normal_mode["<F4>"] = "<ESC>:w<CR>"
lvim.keys.normal_mode["<F8>"] = "<ESC>:q!<CR>"
lvim.keys.normal_mode["<F9>"] = "<ESC>:qa!<CR>"

vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = spaces_for_indent
vim.opt.shiftwidth = spaces_for_indent
vim.opt.colorcolumn = '80'
vim.opt.langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"
vim.opt.autochdir = false -- current directory = path where you execute neovim(lvim)

-- vim.cmd([[autocmd ColorScheme * highlight ColorColumn guibg=#292e42]])
vim.cmd[[
    augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight TypeHint guifg=#306060
    augroup end
]]
vim.cmd([[autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
   \ endif]])
