local telescope = require "telescope"
local actions = require "telescope.actions"
local lga_actions = require "telescope-live-grep-args.actions"

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },

    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = { -- extend mappings
                i = {
                    ["<C-p>"] = lga_actions.quote_prompt(),
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
            },
        },
    },

    pickers = {
        find_files = {
            layout_strategy = "vertical",
            find_command = {
                "fd",
                "--hidden",
                "--no-ignore-vcs",
                "--strip-cwd-prefix",
                "--type",
                "f",

                -- we've told fd to ignore .gitignore so we need to put some back in
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

        live_grep = {
            -- grep_open_files = true,
        },
    },
}

--------------------------------------------------------------------------------
-- key bindings
local builtin = require "telescope.builtin"

vim.keymap.set("v", "!", function()
    local cword = vim.fn.expand "<cword>"
    builtin.live_grep {
        default_text = cword,
    }
end)

vim.keymap.set("n", "<c-t>", builtin.find_files)
vim.keymap.set("n", "<c-space>", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.buffers)
vim.keymap.set("n", "<leader>ff", telescope.extensions.live_grep_args.live_grep_args)

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
