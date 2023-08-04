local M = {}

function M.setup()
    vim.g.rustfmt_autosave = 1
    vim.g.rustfmt_emit_file = 1
    vim.g.rustfmt_fail_silently = 1
    require("crates").setup({})
    require("rust-tools").setup({
        tools = {
            inlay_hints = {
                highlight = "TypeHint" -- :hi {tab}
            }
        }
    })
end

return M
