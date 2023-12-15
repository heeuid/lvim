local M = {}
local function setup_colorizer()
    require("colorizer").setup({
        filetypes = {
            "*", -- Highlight all files, but customize some others.
            cmp_docs = { always_update = true },
        },
    })
end

function M.setup()
    setup_colorizer()
    lvim.colorscheme = "catppuccin-mocha"

    -- lvim.colorscheme = "github_light"
    --    "catppuccin-latte"
    --    "catppuccin-frappe"
    --    "catppuccin-macchiato"
    --    "catppuccin-mocha"
    --lvim.colorscheme = "tokyonight-day"
    --    "tokyonight-storm"
    --    "tokyonight-night"
    --    "tokyonight-moon"

    -- require("shade").setup({
    --     overlay_opacity = 50,
    --     opacity_setup = 1,
    -- })

    -- local ok, wk = pcall(require, "which-key")
    -- if ok then
    --     wk.register({["<space>f"] = {name="+telescope"}}, { noremap = true, silent = true })
    -- end
    -- local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<space>ff', builtin.find_files, {})
    -- vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
    -- vim.keymap.set('n', '<space>fb', builtin.buffers, {})
    -- vim.keymap.set('n', '<space>fh', builtin.help_tags, {})

    -- local map = vim.keymap.set
    -- local ok, wk = pcall(require, "which-key")
    -- if ok then
    --     wk.register({["\\t"] = {name="+toggleterm"}}, { noremap = true, silent = true })
    -- end
    -- -- CTRL + \: off(hide) all terminals
    -- map("n", "\\tf", "<ESC>:ToggleTerm direction=float<CR>", {
    --     noremap = true, silent = true, desc = "toggleterm: floating window" })
    -- map("n", "\\th", "<ESC>:ToggleTerm direction=horizontal<CR>", {
    --     noremap = true, silent = true, desc = "toggleterm: horizontal window" })
    -- map("n", "\\tv", "<ESC>:ToggleTerm direction=vertical<CR>", {
    --     noremap = true, silent = true, desc = "toggleterm: vertical window" })
end

return M
