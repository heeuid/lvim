local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.rs",
      callback = function()
        vim.api.nvim_set_hl(0, "RustTypeHint", {
          fg = "#000000",
          bg = "#406060", --#80c0c0
        })
      end,
    })
    vim.g.rustfmt_autosave = 1
    vim.g.rustfmt_emit_file = 1
    vim.g.rustfmt_fail_silently = 1
    require("crates").setup({})
    require("rust-tools").setup({
        tools = {
            inlay_hints = {
                highlight = "RustTypeHint" -- :hi {tab}
            }
        }
    })
end

return M
