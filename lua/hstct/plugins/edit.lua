return {
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "echasnovski/mini.splitjoin",
        config = function()
            require("mini.splitjoin").setup()
        end,
    },
}
