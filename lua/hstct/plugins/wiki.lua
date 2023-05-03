local g = vim.g
return {
    "lervag/wiki.vim",
    init = function()
        g.wiki_root = "~/.local/wiki"
        g.wiki_filetypes = { "wiki", "md" }
        g.wiki_link_target_type = "wiki"
        g.wiki_link_extension = ""
        g.wiki_mappings_local = {
            ["<plug>(wiki-link-toggle-operator)"] = "gL",
        }
        g.wiki_write_on_nav = 1
        g.wiki_toc_depth = 2
        -- g.wiki_file_handler = "personal#wiki#file_handler"
        local group = vim.api.nvim_create_augroup("init_wiki", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "WikiLinkFollowed",
            desc = "Wiki: Center view on link follow",
            command = [[ normal! zz ]],
        })
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "WikiBufferInitialized",
            desc = "Wiki: add mapping for gf",
            command = [[ nmap <buffer> gf <plug>(wiki-link-follow) ]],
        })
    end,
}
