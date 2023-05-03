return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "go",
                "gomod",
                "python",
                "lua",
                "yaml",
                "json",
                "javascript",
                "bash",
                "typescript",
                "make",
                "toml",
                "markdown",
                "html",
                "ruby",
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["uc"] = "@comment.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]]"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[["] = "@function.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>ps"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>pS"] = "@parameter.inner",
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"
        end,
        build = ":TSUpdate",
        event = "BufReadPost",
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
}
