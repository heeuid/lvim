return {
    { "preservim/tagbar", },
		{
        "iamcco/markdown-preview.nvim",
        config = function() vim.fn["mkdp#util#install"]() end,
    },
    { "rcarriga/nvim-notify",},
    { "dnlhc/glance.nvim",
        config = function() require("glance").setup({}) end,
    },
    { "hrsh7th/cmp-cmdline" },
    -- { "ldelossa/nvim-ide",
    --     config = function() require("ide").setup({}) end,
    -- },
    -- {
    --     "sunjon/shade.nvim"
    -- }
}
