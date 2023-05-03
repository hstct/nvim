return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "ThePrimeagen/harpoon",
    },
    init = function()
        local tb = require("telescope.builtin")
        local uts = require("hstct.util.ts")
        vim.keymap.set("n", "<C-p>", function()
            local ok = pcall(tb.git_files, { show_untracked = true })
            if not ok then
                tb.find_files()
            end
        end)
        vim.keymap.set("n", "<leader>ft", tb.live_grep)
        vim.keymap.set("n", "<leader>fb", tb.buffers)
        vim.keymap.set("n", "<leader>fg", tb.git_status)
        vim.keymap.set("n", "<leader>fk", tb.keymaps)
        vim.keymap.set("n", "<leader>H", tb.help_tags)
        vim.keymap.set("n", "<leader>fw", function() uts.files_wiki() end)
        vim.keymap.set("n", "<leader>ff", function() uts.text_wiki() end)

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<C-h>", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
        vim.keymap.set("n", "'q", function() ui.nav_file(1) end)
        vim.keymap.set("n", "'w", function() ui.nav_file(2) end)
        vim.keymap.set("n", "'e", function() ui.nav_file(3) end)
        vim.keymap.set("n", "'r", function() ui.nav_file(4) end)
    end,
    config = function()
        local t = require("telescope")
        local actions = require("telescope.actions")
        local lactions = require("telescope.actions.layout")
        t.setup {
            defaults = {
                prompt_prefix = " ❯ ",
                initial_mode = "insert",
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                    preview_width = 0.6,
                },
            },
            mappings = {
                i = {
                    ["<ESC>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                    ["<C-s>"] = actions.send_selected_to_qflist,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-h>"] = lactions.toggle_preview,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        }
        t.load_extension("fzf")
        t.load_extension("harpoon")

        require("harpoon").setup()
    end,
}
