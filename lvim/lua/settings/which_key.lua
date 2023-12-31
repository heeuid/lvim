local M = {}

-- options
local opts = {
    nmode = {
        empty = {
            mode = "n",     -- NORMAL mode
            prefix = "",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        },
        space = {
            mode = "n",     -- NORMAL mode
            prefix = "<space>",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        },
        backslash = {
            mode = "n",     -- NORMAL mode
            prefix = "\\",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        }
    },
    vmode = {               -- only visual
        empty = {
            mode = "v",     -- NORMAL mode
            prefix = "",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        },
        space = {
            mode = "v",     -- NORMAL mode
            prefix = "<space>",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        },
        backslash = {
            mode = "v",     -- NORMAL mode
            prefix = "\\",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        }
    }
}

-- cscope setting
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
    local sel = "cword"      -- word under cursor
    if selection == "f" then -- file under cursor
        sel = "cfile"
    end

    return string.format(
        [[<cmd>lua require('cscope_maps').cscope_prompt('%s', vim.fn.expand("<%s>"))<cr>]],
        operation,
        sel
    )
end

local cscope_cmd_opt = function(operation, selection)
    local ret = {
        get_cscope_prompt_cmd(operation, selection),
        cscope_sym_map[operation]
    }
    return ret
end

local diagnostic = function()
    local float = vim.diagnostic.config().float
    if float then
        local config = type(float) == "table" and float or {}
        config.scope = "line"
        vim.diagnostic.open_float(config)
    end
end

local function change_indent(num)
    vim.opt.tabstop = num
    vim.opt.shiftwidth = num
    if num == 8 then
        vim.opt.expandtab = false
    else
        vim.opt.expandtab = true
    end
end

function M.setup()
    local ok, wk = pcall(require, "which-key")
    if ok then
        -- original which-key mapping:
        -- in ~/.local/share/lunarvim/lvim/lua/core/which-key.lua

        -- terminal keymaps:
        --     to open terminal are written
        --     in ~/.config/lvim/lua/settings/common.lua

        -- default keymapping:
        --     ~/.local/share/lunarvim/lvim/lua/lvim/keymappings.lua
        --     indentation, quick fix toggle, resize windows, ...

        -- lsp keymapping:
        --     in  ~/.local/share/lunarvim/lvim/lua/lvim/lsp/config.lua
        --     ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
        --     ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
        --     ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
        --     ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references" },
        --     ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
        --     ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help" },
        --     ["gl"] = {
        --       function()
        --         local float = vim.diagnostic.config().float
        --         if float then
        --           local config = type(float) == "table" and float or {}
        --           config.scope = "line"
        --           vim.diagnostic.open_float(config)
        --         end
        --       end,
        --       "Show line diagnostics",
        --     },

        lvim.builtin.which_key.vmappings = {}
        lvim.builtin.which_key.mappings = {}
        vim.o.timeoutlen = 80

        lvim.builtin.which_key.mappings["G"] = {"<cmd>lua print('test key map')<cr>", "Test Key Map"}

        wk.register({
            ["j"] = { "gj", "Move down one line in wrapped lines" },
            ["k"] = { "gk", "Move up one line in wrapped lines" },
        }, opts.vmode.empty)

        wk.register({
            ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
            ["w"] = { "<cmd>w!<CR>", "Save" },
            ["q"] = { "<cmd>confirm q<CR>", "Quit" },
            ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
        }, opts.vmode.space)

        wk.register({
            ["<tab>"] = { "<cmd>bn<cr>", "Buffer: Next" },
            ["<S-tab>"] = { "<cmd>bp<cr>", "Buffer: Previous" },
            ["_"] = { "<cmd>res -1<cr>", "Resize: -Width" },
            ["+"] = { "<cmd>res +1<cr>", "Resize: +Width" },
            ["-"] = { "<esc><c-w><", "Resize: -Height" },
            ["="] = { "<esc><c-w>>", "REsize: +Height" },
            ["<F9>"] = { "<cmd>qa!<cr>", "Quit All" },
            ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
            g = {
                ["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
                ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
                ["r"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references" },
                ["I"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
                ["s"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help" },
                ["l"] = { diagnostic, "Show line diagnostics" },
                ["R"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                ["g"] = { "gg", "Goto top line" },
            },
            ["d"] = {
                ["d"] = { "dd", "Delete This Line" },
                ["k"] = { "dk", "Delete his Line + Above Line" },
                ["j"] = { "dj", "Delete This Line + Below Line" },
                ["h"] = { "dh", "Delete Left Character(Backspace)" },
                ["l"] = { "dh", "Delete This Character(Delete)" },
            },
            ["j"] = { "gj", "Move down one line in wrapped lines" },
            ["k"] = { "gk", "Move up one line in wrapped lines" },
        }, opts.nmode.empty)

        wk.register({ -- for "<sapce>[0-9a-zA-Z]+"
            ["p"] = {
                function()
                    if not vim.opt.wrap:get() then
                        vim.opt.wrap = true
                        vim.opt.linebreak = true
                    else
                        vim.opt.wrap = false
                        vim.opt.linebreak = false
                    end
                end, "Wrap a line" },
            [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
            ["w"] = { "<cmd>w!<CR>", "Save" },
            ["W"] = { "<cmd>Workspace LeftPanelToggle<cr>", "Toggle nvim-ide left pannel" },
            ["q"] = { "<cmd>confirm q<CR>", "Quit" },
            ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
            ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
            ["f"] = {
                function()
                    require(
                        "lvim.core.telescope.custom-finders"
                    ).find_project_files({ previewer = true }) --false })
                end, "Find File",
            },
            ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
            ["e"] = { "<cmd>NvimTreeFocus<CR>", "Explorer" },
            ["r"] = { "<cmd>Telescope live_grep<cr>", "Grep Text" },
            ["m"] = { "<cmd>Telescope marks<cr>", "Mark List" },
            ["t"] = { "<cmd>Tagbar<cr>", "Tagbar" },
            ["o"] = { "<cmd>Telescope oldfiles<cr>", "Old(Past) Files" },
            ["b"] = { "<cmd>Telescope buffers<cr>", "Buffer List" },
            ["v"] = { "<cmd>Telescope buffers<cr>", "Buffer List" },
            ["8"] = { "<cmd>f<cr>", "Current File Path" },
            ["9"] = { "<cmd>pwd<cr>", "Current Dir Path" },
            ["d"] = { "<cmd>lua vim.cmd('Cscope find g ' .. vim.fn.expand('<cword>'))<cr>", "Cscope Global Def. List" },
            ["s"] = { "<cmd>lua vim.cmd('ts ' .. vim.fn.expand('<cword>'))<cr>", "Tag Select Current Word" },
            ["D"] = { function() vim.diagnostic.setloclist() end, "Diagnostic setloclist",},
        }, opts.nmode.space)

        wk.register({ -- for "\\[0-9a-zA-Z]+"
            i = {
                name = "Indentation",
                ["2"] = {function() change_indent(2) end, "Change Indent into 2"},
                ["4"] = {function() change_indent(4) end, "Change Indent into 4"},
                ["8"] = {function() change_indent(8) end, "Change Indent into 8"},
            },
            t = { "<cmd>Tagbar<cr>", "Tagbar" },
            e = {
                --r = {"<cmd>NvimTreeRefresh<cr>", "Open NvimTree"},
                o = {"<cmd>NvimTreeToggle<cr>", "Open NvimTree"},
                t = {"<cmd>NvimTreeOpen<cr>", "Toggle NvimTree"},
                e = {"<cmd>NvimTreeFocus<crc>", "Focus NvimTree"},
                f = {"<cmd>NvimTreeFindFileToggle<crc>", "Toggle NvimTree and Find current file"},
            },
            c = {
                name = "Cscope",
                s = cscope_cmd_opt("s", "w"),
                g = cscope_cmd_opt("g", "w"),
                c = cscope_cmd_opt("c", "w"),
                t = cscope_cmd_opt("t", "w"),
                e = cscope_cmd_opt("e", "w"),
                f = cscope_cmd_opt("f", "f"),
                i = cscope_cmd_opt("i", "f"),
                d = cscope_cmd_opt("d", "w"),
                a = cscope_cmd_opt("a", "w"),
                b = { "<cmd>Cscope build<cr>", cscope_sym_map.b },
            },
            b = {
                name = "Buffers",
                j = { "<cmd>BufferLinePick<cr>", "Jump" },
                f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
                b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
                n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
                W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
                -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
                e = {
                    "<cmd>BufferLinePickClose<cr>",
                    "Pick which buffer to close",
                },
                h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
                l = {
                    "<cmd>BufferLineCloseRight<cr>",
                    "Close all to the right",
                },
                D = {
                    "<cmd>BufferLineSortByDirectory<cr>",
                    "Sort by directory",
                },
                L = {
                    "<cmd>BufferLineSortByExtension<cr>",
                    "Sort by language",
                },
                c = { "<cmd>BufferKill<CR>", "Close Buffer" },
            },
            d = {
                name = "Debug",
                t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
                b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
                c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
                C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
                d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
                g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
                i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
                o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
                u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
                p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
                r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
                s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
                q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
                U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
            },
            p = {
                name = "Lazy Plugins",
                i = { "<cmd>Lazy install<cr>", "Install" },
                s = { "<cmd>Lazy sync<cr>", "Sync" },
                S = { "<cmd>Lazy clear<cr>", "Status" },
                c = { "<cmd>Lazy clean<cr>", "Clean" },
                u = { "<cmd>Lazy update<cr>", "Update" },
                p = { "<cmd>Lazy profile<cr>", "Profile" },
                l = { "<cmd>Lazy log<cr>", "Log" },
                d = { "<cmd>Lazy debug<cr>", "Debug" },
            },

            -- " Available Debug Adapters:
            -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
            -- " Adapter configuration and installation instructions:
            -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
            -- " Debug Adapter protocol:
            -- "   https://microsoft.github.io/debug-adapter-protocol/
            -- " Debugging
            g = {
                name = "Git",
                g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
                j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
                k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
                l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Git Blame(Who Changed)" },
                p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
                r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
                R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
                s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
                u = {
                    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                    "Undo Stage Hunk",
                },
                o = { "<cmd>Telescope git_status<cr>", "Git Status(Open Changed Files)" },
                b = { "<cmd>Telescope git_branches<cr>", "Git Checkout Branch" },
                c = { "<cmd>Telescope git_commits<cr>", "Git Checkout Commit" },
                C = {
                    "<cmd>Telescope git_bcommits<cr>",
                    "Git Checkout commit(for current file)",
                },
                d = {
                    "<cmd>Gitsigns diffthis HEAD<cr>",
                    "Git Diff",
                },
            },
            w = {
                name = "workspace",
                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace" },
                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace" },
                l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspace" },
            },
            l = {
                name = "LSP",
                a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
                d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
                W = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
                f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
                i = { "<cmd>LspInfo<cr>", "Info" },
                I = { "<cmd>Mason<cr>", "Mason Info" },
                n = {
                    "<cmd>lua vim.diagnostic.goto_next()<cr>",
                    "Next Diagnostic",
                },
                p = {
                    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                    "Prev Diagnostic",
                },
                l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
                q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
                r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                S = {
                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                    "Workspace Symbols",
                },
                e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
				w = {
					name = "workspace",
					a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace" },
					r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace" },
					l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspace" },
				},
				D = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Def." },
				K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Explanation" },
				g = {
					name = "Goto...",
					d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
					D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
					r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references" },
					i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
					s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help" },
				},
            },
            L = {
                name = "+LunarVim",
                c = {
                    "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
                    "Edit config.lua",
                },
                d = { "<cmd>LvimDocs<cr>", "View LunarVim's docs" },
                f = {
                    "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
                    "Find LunarVim files",
                },
                g = {
                    "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
                    "Grep LunarVim files",
                },
                k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
                i = {
                    "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
                    "Toggle LunarVim Info",
                },
                I = {
                    "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
                    "View LunarVim's changelog",
                },
                l = {
                    name = "+logs",
                    d = {
                        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
                        "view default log",
                    },
                    D = {
                        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
                        "Open the default logfile",
                    },
                    l = {
                        "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
                        "view lsp log",
                    },
                    L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
                    n = {
                        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
                        "view neovim log",
                    },
                    N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
                },
                r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
                u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
            },
            s = {
                name = "Search",
                b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
                f = { "<cmd>Telescope find_files<cr>", "Find File" },
                h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
                H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
                M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
                r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                R = { "<cmd>Telescope registers<cr>", "Registers" },
                t = { "<cmd>Telescope live_grep<cr>", "Text" },
                k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                C = { "<cmd>Telescope commands<cr>", "Commands" },
                l = { "<cmd>Telescope resume<cr>", "Resume last search" },
                p = {
                    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
                    "Colorscheme with Preview",
                },
            },
            T = {
                name = "Treesitter",
                i = { ":TSConfigInfo<cr>", "Info" },
            },
            -- W = {
            --     name = "nvim-ide",
            --     w = { "<cmd>Workspace<cr>", "Show/Select Commands" },
            --     l = { "<cmd>Workspace LeftPanelToggle<cr>", "Toggles Left Panels"},
            --     r = { "<cmd>Workspace RightPanelToggle<cr>", "Toggles Right Panels"},
            --     g = { "<cmd>Workspace OpenLog<cr>", "Open Log"},
            --     R = { "<cmd>Workspace Reset<cr>", "Reset(Resize) All Pannels"},
            -- },
        }, opts.nmode.backslash)
    end
end

return M
