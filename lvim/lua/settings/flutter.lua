local M = {}

function M.setup()
    require('flutter-tools').setup({})
    vim.keymap.set('n', "\\fo", "<CMD>:FlutterOutlineToggle<CR>")
    vim.keymap.set('n', "\\fr", "<CMD>:FlutterRun<CR>")
    vim.keymap.set('n', "\\fl", "<CMD>:FlutterReload<CR>")
end

return M
