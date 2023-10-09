-- settings independent from plugins

local spaces_for_indent = 4

vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = spaces_for_indent
vim.opt.shiftwidth = spaces_for_indent
vim.opt.colorcolumn = '80'
vim.opt.langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"
vim.opt.autochdir = false -- current directory = path where you execute neovim(lvim)

vim.cmd([[autocmd ColorScheme * highlight ColorColumn guibg=#292e42]])
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
vim.cmd([[
	autocmd FileType c setlocal noexpandtab shiftwidth=8 tabstop=8
	autocmd FileType make setlocal noexpandtab shiftwidth=8 tabstop=8
	autocmd BufRead,BufNewFile *.dts setlocal noexpandtab shiftwidth=8 tabstop=8
	autocmd BufRead,BufNewFile *.dtsi setlocal noexpandtab shiftwidth=8 tabstop=8
	autocmd BufRead,BufNewFile Kconfig* setlocal noexpandtab shiftwidth=8 tabstop=8
	autocmd BufRead,BufNewFile *_defconfig setlocal noexpandtab shiftwidth=8 tabstop=8
]])
