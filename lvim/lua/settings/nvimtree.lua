local M = {}

function M.setup()
    lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true
    lvim.builtin.nvimtree.setup.renderer.indent_markers.icons.item = "├"
end

return M
