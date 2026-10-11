local packer = require "packer"

packer.init {
    git = {
        clone_timeout = 180,
    },
}

packer.startup(function(use)
    -- packer, need to bootstrap this with a manual git clone on a fresh machine
    use "wbthomason/packer.nvim"

    ----------------------------------------
    -- editing
    ----------------------------------------

    -- comment stuff with gc (VISUAL)
    use "tpope/vim-commentary"

    -- surround stuff gS (VISUAL) or cs"' (NORMAL)
    use "tpope/vim-surround"

    -- split lines with gS (NORMAL)
    use "AndrewRadev/splitjoin.vim"

    -- .editorconfig file support
    use "editorconfig/editorconfig-vim"

    use "github/copilot.vim"

    ----------------------------------------
    -- navigation & ui
    ----------------------------------------

    -- better syntax highlighting, used by telescope (setup in plugins/treesitter.lua)
    use {
        -- `main` is required for nvim 0.12; `master` is frozen at nvim 0.11.
        -- Parsers must be kept in sync with the plugin via :TSUpdate.
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        run = ":TSUpdate",
    }

    -- telescope (setup in plugins/telescope.lua)
    use {
        -- `master`, not the `0.1.x` tag line: 0.1.x's previewer highlights via
        -- `nvim-treesitter.configs`/`parsers.ft_to_lang`, which the treesitter
        -- `main` branch removed. `master` highlights through core treesitter.
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }
    use "nvim-telescope/telescope-live-grep-args.nvim"

    -- sidebar file tree (setup in plugins/nvim-tree.lua)
    use "nvim-tree/nvim-tree.lua"

    -- status line and buffer tabs (setup in plugins/lualine.lua, plugins/bufferline.lua)
    use "nvim-lualine/lualine.nvim"
    use "akinsho/bufferline.nvim"

    -- theme
    use "EdenEast/nightfox.nvim"

    -- icons for nvim-tree, lualine and bufferline
    use "nvim-tree/nvim-web-devicons"

    -- git change markers in the gutter (setup in plugins/gitsigns.lua)
    use "lewis6991/gitsigns.nvim"

    ----------------------------------------
    -- lsp & completion
    ----------------------------------------

    -- server configs, used by vim.lsp.config/enable in lsp.lua
    use "neovim/nvim-lspconfig"

    -- formatters as an lsp (setup in plugins/none-ls.lua)
    use {
        "nvimtools/none-ls.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }

    -- completion (setup in plugins/cmp.lua)
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/cmp-vsnip"

    ----------------------------------------
    -- languages
    ----------------------------------------

    use "rust-lang/rust.vim"

    use {
        -- NOTE: packer has no lazy.nvim-style `version` key -- it only supports
        -- tag/branch/commit/rev, so `version` was silently ignored and this
        -- tracked `main`. `tag` is the real pin.
        "https://github.com/mrcjkb/haskell-tools.nvim",
        tag = "v10.0.1",
    }
end)
