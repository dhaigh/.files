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
    use "nvim-treesitter/nvim-treesitter"
    use "tree-sitter/tree-sitter-typescript"

    -- telescope
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } },
    }
    use "nvim-telescope/telescope-live-grep-args.nvim"

    -- sidebar file tree
    use "scrooloose/nerdtree"

    -- .editorconfig file support
    use "editorconfig/editorconfig-vim"

    -- ts/js syntax highlighting
    -- use 'yuezk/vim-js'
    -- use "maxmellon/vim-jsx-pretty"
    -- use "HerringtonDarkholme/yats.vim"

    -- lsp stuff
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"

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
    use "ryanoasis/vim-devicons"

    -- completion (setup in completion.lua)
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/cmp-vsnip"

    use "github/copilot.vim"
    
    use "rust-lang/rust.vim"
end)
