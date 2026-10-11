-- nvim-treesitter `main` branch. The old `master` branch is frozen for nvim 0.11
-- and crashes on 0.12 (its query predicates still assume a treesitter match is a
-- single node rather than a list), which tears down the highlighter and kills all
-- highlighting. `main` has no `configs` module: parsers and queries are installed
-- into `install_dir`, and highlighting comes from Neovim core.
require("nvim-treesitter").setup {}

local ts_parsers = {
    "bash",
    "diff",
    "dockerfile",
    "embedded_template",
    "git_config",
    "gitcommit",
    "gitignore",
    "haskell",
    "ini",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "markdown_inline",
    "mermaid",
    "pem",
    "python",
    "ruby",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

-- Async, and a no-op for parsers that are already installed.
require("nvim-treesitter").install(ts_parsers)

-- `main` does not enable highlighting itself; core does, per buffer.
-- pcall since not every filetype we open has a parser installed.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
