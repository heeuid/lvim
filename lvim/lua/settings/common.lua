local M = {}

local function config_lastplace()
   require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = {
     "gitcommit", "gitrebase", "svn", "hgcommit",
    },
    lastplace_open_folds = true,
   })
end

local function config_colorizer()
    require("colorizer").setup(
        {'*';},
        {
            RGB = true;
            RRGGBB = true;
            names = true;
            RRGGBBAA = true;
            rgb_fn = true;
            hsl_fn = true;
            css = true;
            css_fn = true;
        }
    )
end

function M.setup()
    lvim.builtin.project.manual_mode = true

    lvim.builtin.terminal.execs[1][2] = "<space>1"
    lvim.builtin.terminal.execs[2][2] = "<space>2"
    lvim.builtin.terminal.execs[3][2] = "<space>3"

    lvim.builtin.cmp.cmdline.enable = true

    config_lastplace()
    config_colorizer()

    -- lvim.colorscheme = "github_light"
    lvim.colorscheme = "catppuccin-latte"
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
