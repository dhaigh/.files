-- nvim-tree setup
--------------------------------------------------------

vim.keymap.set("n", "<leader>r", ":NvimTreeFindFile<cr>")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 50,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
        git_ignored = false,
    },
    update_focused_file = {
        enable = true,
        update_root = false,
    },
}
