local actions = require "telescope.actions"

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = {
                "fd",
                "--hidden",
                "--no-ignore-vcs",
                "--strip-cwd-prefix",
                "--type",
                "f",

                -- we've told fd to ignore .gitignore so we need to put some
                -- back in
                "--exclude",
                "node_modules",

                "--exclude",
                "*.pyc",

                "--exclude",
                "*.png",

                "--exclude",
                "**/.yarn/cache",

                "--exclude",
                ".git/",
            },
        },
    },
}
