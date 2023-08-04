local M = {}

function M.setup()
    local map = vim.keymap.set
    local cscope_sym_map = {
        s = "Find this symbol",
        g = "Find this global defination",
        c = "Find functions calling this function",
        t = "Find this text string",
        e = "Find this egrep pattern",
        f = "Find this file",
        i = "Find files #including this file",
        d = "Find functions called by this function",
        a = "Find places where this symbol is assigned a value",
        b = "Build database",
    }
    local get_cscope_prompt_cmd = function(operation, selection)
        local sel = "cword" -- word under cursor
        if selection == "f" then -- file under cursor
            sel = "cfile"
        end

        return string.format(
            [[<cmd>lua require('cscope_maps').cscope_prompt('%s', vim.fn.expand("<%s>"))<cr>]],
            operation,
            sel
        )
    end

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register({["\\c"] = {name="+cscope"}}, { noremap = true, silent = true })
    end
    map("n", "\\cs", get_cscope_prompt_cmd("s", "w"), { noremap = true, silent = true , desc=cscope_sym_map.s })
    map("n", "\\cg", get_cscope_prompt_cmd("g", "w"), { noremap = true, silent = true , desc=cscope_sym_map.g })
    map("n", "\\cc", get_cscope_prompt_cmd("c", "w"), { noremap = true, silent = true , desc=cscope_sym_map.c })
    map("n", "\\ct", get_cscope_prompt_cmd("t", "w"), { noremap = true, silent = true , desc=cscope_sym_map.t })
    map("n", "\\ce", get_cscope_prompt_cmd("e", "w"), { noremap = true, silent = true , desc=cscope_sym_map.e })
    map("n", "\\cf", get_cscope_prompt_cmd("f", "f"), { noremap = true, silent = true , desc=cscope_sym_map.f })
    map("n", "\\ci", get_cscope_prompt_cmd("i", "f"), { noremap = true, silent = true , desc=cscope_sym_map.i })
    map("n", "\\cd", get_cscope_prompt_cmd("d", "w"), { noremap = true, silent = true , desc=cscope_sym_map.d })
    map("n", "\\ca", get_cscope_prompt_cmd("a", "w"), { noremap = true, silent = true , desc=cscope_sym_map.a })
    map("n", "\\cb", "<cmd>Cscope build<cr>", { noremap = true, silent = true , desc=cscope_sym_map.b })
end

return M
