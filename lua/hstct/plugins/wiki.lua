return {
    "mickael-menu/zk-nvim",
    config = function()
        local zk = require("zk")
        local util = require("zk.util")
        local commands = require("zk.commands")
        local u = require("hstct.util.functions")

        local function make_edit_fn(defaults, picker_options)
            return function(options)
                options = vim.tbl_extend("force", defaults, options or {})
                zk.edit(options, picker_options)
            end
        end

        local function make_new_fn(defaults)
            return function(options)
                options = vim.tbl_extend("force", defaults, options or {})
                zk.new(options)
            end
        end

        local function make_new_prompt_fn()
            return function()
                vim.ui.input({ prompt = "Note Title: " }, function(title)
                    zk.new({ title = title })
                end, "New Note")
            end
        end

        zk.setup({
            picker = "telescope",
            lsp = {
                config = {
                    cmd = { "zk", "lsp" },
                    name = "zk",
                },
                auto_attach = {
                    enabled = true,
                    filetypes = { "markdown" },
                },
            },
        })

        commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
        commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))
        commands.add("ZkLiveGrep", function(options)
            options = options or {}
            local notebook_path = options.notebook_path or util.resolve_notebook_path(0)
            local notebook_root = util.notebook_root(notebook_path)
            if notebook_root then
                require("telescope.builtin").live_grep({ cwd = notebook_root, prompt_title = "Zk Live Grep" })
            else
                vim.notify("No notebook found", vim.log.levels.ERROR)
            end
        end)
        commands.add("ZkNewNote", make_new_prompt_fn())
        commands.add("ZkNewDailyNote", make_new_fn({ dir = "meetings/daily" }))
        commands.add("ZkDaily", make_edit_fn({ hrefs = { "meetings/daily" }, sort = { "created" } }, { title = "Zk Daily" }))

        u.map("n", "<leader>zn", "<cmd>ZkNewNote<CR>")
        u.map("n", "<leader>zf", "<cmd>ZkLiveGrep<CR>")
        u.map("n", "<leader>zp", "<cmd>ZkNotes { sort = { 'modified' } }<CR>")
        u.map("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>")
        u.map("n", "<leader>zb", "<cmd>ZkBacklinks<CR>")
        u.map("n", "<leader>zl", "<cmd>ZkLinks<CR>")
        u.map("n", "<leader>zd", "<cmd>ZkNewDailyNote<CR>")
        u.map("n", "<leader>zt", "<cmd>ZkTags<CR>")
    end,
}
