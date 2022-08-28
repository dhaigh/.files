require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- comment stuff with gc (VISUAL)
    use "tpope/vim-commentary"

    -- surround stuff gS (VISUAL) or cs"' (NORMAL)
    use "tpope/vim-surround"

    -- split lines with gS (NORMAL)
    use "AndrewRadev/splitjoin.vim"

    -- fuzzy finding (yes both are needed)
    use "junegunn/fzf"
    use "junegunn/fzf.vim"

    -- sidebar file tree
    use "scrooloose/nerdtree"

    -- .editorconfig file support
    use "editorconfig/editorconfig-vim"

    -- ts/js syntax highlighting
    -- use 'yuezk/vim-js'
    -- use 'maxmellon/vim-jsx-pretty'
    -- use 'HerringtonDarkholme/yats.vim'

    -- lsp stuff
    use "neovim/nvim-lspconfig"

    -- more lsp stuff (null-ls depends on plenary.nvim)
    use "nvim-lua/plenary.nvim"
    use "jose-elias-alvarez/null-ls.nvim"

    -- themey stuff
    use "nvim-lualine/lualine.nvim"
    use "akinsho/bufferline.nvim"

    -- theme
    use "EdenEast/nightfox.nvim"

    -- integration with typescript-language-server
    use "jose-elias-alvarez/typescript.nvim"
end)
