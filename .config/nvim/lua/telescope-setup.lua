local telescope = require "telescope"
local actions = require "telescope.actions"
local lga_actions = require "telescope-live-grep-args.actions"
local action_state = require "telescope.actions.state"

-- copied from here:
-- https://github.com/nvim-telescope/telescope.nvim/issues/416#issuecomment-841273053
local function fzf_multi_select(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())

    if num_selections > 1 then
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist()
    else
        actions.file_edit(prompt_bufnr)
    end
end

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<c-u>"] = false,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
                ["<cr>"] = fzf_multi_select,
            },
        },
    },

    extensions = {
        live_grep_args = {
            mappings = {
                i = {
                    ["<c-p>"] = lga_actions.quote_prompt(),
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<cr>"] = fzf_multi_select,
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

                "--exclude",
                "tmp/",
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
