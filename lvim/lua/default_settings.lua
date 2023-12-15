-- settings independent from plugins

local spaces_for_indent = 4

vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = spaces_for_indent
vim.opt.shiftwidth = spaces_for_indent
vim.opt.colorcolumn = '80'
vim.opt.langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"
vim.opt.autochdir = false -- current directory = path where you execute neovim(lvim)
vim.opt.wrap = true
vim.opt.linebreak = true

--------------
-- Autocmds --
--------------

vim.cmd([[autocmd ColorScheme * highlight ColorColumn guibg=#401010]])
-- vim.cmd([[autocmd BufReadPost *
--   \ if line("'\"") >= 1 && line("'\"") <= line("$") |
--   \   exe "normal! g`\"" |
--    \ endif]])

-- Filetype
local filetype_pattern_pairs = {
  { "t32", "*.cmm" },
}
for _, elem in pairs(filetype_pattern_pairs) do
  local filetype = elem[1]
  local pattern = elem[2]
  --vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = pattern,
    callback = function()
      vim.bo.filetype = filetype
    end,
  })
end

-- Indentation
local event_indent_pairs = {
  { { "FileType" }, { "c", "make" }, 8, false },
  { { "FileType" }, { "lua" }, 2, true },
  {
    { "BufRead", "BufNewFile" },
    { "*.dts", "*.dtsi", "Kconfig*", "*_defconfig" },
    8,
    false,
  },
}
for _, elem in pairs(event_indent_pairs) do
  local events = elem[1]
  local patterns = elem[2]
  local tabspace = elem[3]
  local tab_expandable = elem[4]
  vim.api.nvim_create_autocmd(events, {
    pattern = patterns,
    callback = function()
      vim.opt.tabstop = tabspace
      vim.opt.shiftwidth = tabspace
      vim.opt.expandtab = tab_expandable
    end,
  })
end
