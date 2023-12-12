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

function M.setup()
    lvim.builtin.project.manual_mode = true

    lvim.builtin.terminal.execs[1][2] = "<space>1"
    lvim.builtin.terminal.execs[2][2] = "<space>2"
    lvim.builtin.terminal.execs[3][2] = "<space>3"

    lvim.builtin.cmp.cmdline.enable = true

    config_lastplace()

end

return M
