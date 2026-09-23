local packer = require "packer"

packer.init {
    git = {
        clone_timeout = 180,
    },
}

packer.startup(function(use)
    -- packer, need to bootstrap this with a manual git clone on a fresh machine
    use "wbthomason/packer.nvim"

    -- comment stuff with gc (VISUAL)
    use "tpope/vim-commentary"

    -- surround stuff gS (VISUAL) or cs"' (NORMAL)
    use "tpope/vim-surround"

    -- split lines with gS (NORMAL)
    use "AndrewRadev/splitjoin.vim"

    -- better syntax highlighting, used by telescope
    use {
        -- `main` is required for nvim 0.12; `master` is frozen at nvim 0.11.
        -- Parsers must be kept in sync with the plugin via :TSUpdate.
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        run = ":TSUpdate",
    }
    -- use "tree-sitter/tree-sitter-typescript"

    -- telescope
    use {
        -- `master`, not the `0.1.x` tag line: 0.1.x's previewer highlights via
        -- `nvim-treesitter.configs`/`parsers.ft_to_lang`, which the treesitter
        -- `main` branch removed. `master` highlights through core treesitter.
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }
    use "nvim-telescope/telescope-live-grep-args.nvim"

    -- sidebar file tree
    use "nvim-tree/nvim-tree.lua"

    -- .editorconfig file support
    use "editorconfig/editorconfig-vim"

    -- ts/js syntax highlighting
    -- use 'yuezk/vim-js'
    -- use "maxmellon/vim-jsx-pretty"
    -- use "HerringtonDarkholme/yats.vim"

    -- lsp stuff
    use "neovim/nvim-lspconfig"

    -- more lsp stuff
    use {
        "nvimtools/none-ls.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }

    -- themey stuff
    use "nvim-lualine/lualine.nvim"
    use "akinsho/bufferline.nvim"

    -- theme
    use "EdenEast/nightfox.nvim"

    -- integration with typescript-language-server
    -- use "jose-elias-alvarez/typescript.nvim"

    -- icons for nerdtree
    use "nvim-tree/nvim-web-devicons"

    -- completion (setup in completion.lua)
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/cmp-vsnip"

    use "github/copilot.vim"

    use "rust-lang/rust.vim"

    -- git change markers in the gutter, relative to master (like `git diff master...`)
    --   <leader>gt  toggle the markers on/off
    --   <leader>gm  re-resolve the merge base with master (after merging/rebasing master)
    --   <leader>gi  diff against the index instead
    --   <leader>gd  vimdiff the current buffer against the current base
    --   ]c / [c     jump to next/previous hunk
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gs = require "gitsigns"

            -- merge base of master and HEAD, for the repo containing the current
            -- buffer (or nvim's cwd if the buffer has no file). gitsigns needs a
            -- single revision, so `master...` itself can't be used as the base.
            local function merge_base(quiet)
                local dir = vim.fn.expand "%:p:h"
                if dir == "" then
                    dir = vim.fn.getcwd()
                end
                local out = vim.fn.systemlist { "git", "-C", dir, "merge-base", "master", "HEAD" }
                if vim.v.shell_error ~= 0 or out[1] == nil then
                    if not quiet then
                        vim.notify("gitsigns: could not find merge base with master", vim.log.levels.WARN)
                    end
                    return nil
                end
                return out[1]
            end

            -- nil (index) if we're not in a repo or there's no master
            gs.setup { base = merge_base(true) }

            vim.keymap.set("n", "<leader>gt", gs.toggle_signs)
            vim.keymap.set("n", "<leader>gm", function()
                local base = merge_base()
                if base then
                    gs.change_base(base, true)
                end
            end)
            vim.keymap.set("n", "<leader>gi", function()
                gs.change_base(nil, true)
            end)
            vim.keymap.set("n", "<leader>gd", gs.diffthis)
            vim.keymap.set("n", "]c", gs.next_hunk)
            vim.keymap.set("n", "[c", gs.prev_hunk)
        end,
    }

    use {
        -- NOTE: packer has no lazy.nvim-style `version` key -- it only supports
        -- tag/branch/commit/rev, so `version` was silently ignored and this
        -- tracked `main`. `tag` is the real pin.
        "https://github.com/mrcjkb/haskell-tools.nvim",
        tag = "v10.0.1",
    }
end)
