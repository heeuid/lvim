local M = {}

local kind_text = {
	Array = "arry",
	Boolean = "bool",
	Class = "clss",
	Color = "colr",
	Constant = "cnst",
	Constructor = "ctor",
	Enum = "enum",
	EnumMember = "emem",
	Event = "even",
	Field = "fiel",
	File = "file",
	Folder = "dire",
	Function = "func",
	Interface = "intf",
	Key = "key_",
	Keyword = "kywd",
	Method = "mthd",
	Module = "modu",
	Namespace = "nspc",
	Null = "null_",
	Number = "numb",
	Object = "objt",
	Operator = "oprt",
	Package = "pack",
	Property = "prpt",
	Reference = "refr",
	Snippet = "snip",
	String = "stri",
	Struct = "strt",
	Text = "text",
	TypeParameter = "tprm",
	Unit = "unit",
	Value = "valu",
	Variable = "vari",
}

local format = function(entry, vim_item)
	local max_width = lvim.builtin.cmp.formatting.max_width
	if max_width ~= 0 and #vim_item.abbr > max_width then
		vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
	end
	if lvim.use_icons then
		local kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]

		if entry.source.name == "copilot" then
			kind = lvim.icons.git.Octoface
			vim_item.kind_hl_group = "CmpItemKindCopilot"
		end

		if entry.source.name == "cmp_tabnine" then
			kind = lvim.icons.misc.Robot
			vim_item.kind_hl_group = "CmpItemKindTabnine"
		end

		if entry.source.name == "crates" then
			kind = lvim.icons.misc.Package
			vim_item.kind_hl_group = "CmpItemKindCrate"
		end

		if entry.source.name == "lab.quick_data" then
			kind = lvim.icons.misc.CircuitBoard
			vim_item.kind_hl_group = "CmpItemKindConstant"
		end

		if entry.source.name == "emoji" then
			kind = lvim.icons.misc.Smiley
			vim_item.kind_hl_group = "CmpItemKindEmoji"
		end

		vim_item.kind = kind .. " " .. kind_text[vim_item.kind]
	end
	vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name]
	vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
		or lvim.builtin.cmp.formatting.duplicates_default
	return vim_item
end

function M.setup()
	lvim.builtin.cmp.formatting.format = format

	lvim.lsp.installer.setup.ensure_installed = {
		"lua_ls",
		"clangd",
		"pyright",
		"rust_analyzer",
		"vimls",
		"bashls",
		"jsonls",
		"lemminx",
		"yamlls",
		"taplo",
	}

	local formatters = require("lvim.lsp.null-ls.formatters")
	formatters.setup({
		{ name = "black" },
		{ name = "stylua" },
		{ name = "xmlformat" },
		{ name = "prettier" },
        { name = "beautysh" },
	})

	-- local linters = require("lvim.lsp.null-ls.linters")
	-- linters.setup({
	-- 	{ name = "flake8" },
	-- 	{ name = "shellcheck", args = { "--serverity", "warning" } },
	-- })

	-- lvim.format_on_save.enabled = true
	-- lvim.format_on_save.pattern = { "*.lua", "*.py", "*.c", "*.h" }

	-- local lspconfig = require("lspconfig")
	-- lspconfig.pyright.setup({})
	-- lspconfig.clangd.setup({})
	-- lspconfig.rust_analyzer.setup({
	--     settings = {
	--         ["rust-analyzer"] = {}
	--     }
	-- })

	-- vim.api.nvim_create_autocmd('LspAttach', {
	--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	--     callback = function(ev)
	--         -- Enable completion triggered by <c-x><c-o>
	--         vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

	--         -- Buffer local mappings.
	--         -- See `:help vim.lsp.*` for documentation on any of the below functions
	--         local opts = { buffer = ev.buf }
	--         vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	--         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	--         vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	--         vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	--         --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	--         vim.keymap.set('n', '\\wa', vim.lsp.buf.add_workspace_folder, opts)
	--         vim.keymap.set('n', '\\wr', vim.lsp.buf.remove_workspace_folder, opts)
	--         vim.keymap.set('n', '\\wl', function()
	--           print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	--         end, opts)
	--         vim.keymap.set('n', '\\D', vim.lsp.buf.type_definition, opts)
	--         vim.keymap.set('n', '\\rn', vim.lsp.buf.rename, opts)
	--         --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
	--         vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	--         vim.keymap.set('n', '\\F', function()
	--           vim.lsp.buf.format { async = true }
	--         end, opts)
	--     end,
	-- })
end

return M
