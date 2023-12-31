return {
    { "preservim/tagbar", },
    {
        "iamcco/markdown-preview.nvim",
        config = function() vim.fn["mkdp#util#install"]() end,
    },
    { "rcarriga/nvim-notify", },
    {
        "projekt0n/github-nvim-theme",
        config = function() require('github-theme').setup({}) end
    },
    {
        "ethanholz/nvim-lastplace",
        event = "BufRead",
    },
    -- { "dnlhc/glance.nvim",
    --     config = function() require("glance").setup({}) end,
    -- },
    -- { "ldelossa/nvim-ide",
    --     config = function() require("ide").setup({}) end,
    -- },
    -- {
    --     "sunjon/shade.nvim"
    -- }
}
