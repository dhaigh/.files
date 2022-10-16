local group = vim.api.nvim_create_augroup("reload lua config", {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "**/.config/nvim/**/*.lua" },
    group = group,
    callback = function(opts)
        vim.notify("Loaded " .. opts.file)
        dofile(opts.file)
    end,
})

-- clear trailing whitespace, ensure one blank line at the end
-- autocmd BufWritePre * %s/\s\+$//e

----------------------------------------
-- basic config
----------------------------------------

vim.api.nvim_set_option("expandtab", true) -- <tab> produces spaces
vim.api.nvim_set_option("softtabstop", 4)
vim.api.nvim_set_option("shiftwidth", 4)

----------------------------------------
-- key bindings
----------------------------------------
-- use vim.keymap instead of nvim_set_keymap
-- https://www.reddit.com/r/neovim/comments/uuh8xw/comment/i9g59nx/?utm_source=reddit&utm_medium=web2x&context=3

-- the all important
vim.keymap.set("i", "<c-c>", "<esc>")

-- window navigation
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- paragraph navigation
vim.keymap.set({ "n", "v" }, "<c-j>", "}")
vim.keymap.set({ "n", "v" }, "<c-k>", "{")

-- buffers
vim.keymap.set("n", "<tab>", ":bn<cr>")
vim.keymap.set("n", "<s-tab>", ":bp<cr>")
vim.keymap.set("n", "<leader>q", ":bd<cr>")
vim.keymap.set("n", "<leader>b", ":bufdo bd<cr>")

-- ergonomics (- is next to 0)
vim.keymap.set("n", "-", "$")
vim.keymap.set("v", "-", "$h")

-- ergonomics ($ is next to #)
vim.keymap.set("n", "$", "*")

-- clear highlight
vim.keymap.set("n", "<c-n>", ":noh<cr>")

-- wholesome emacsy bindings
vim.keymap.set("n", "<c-a>", "^")
vim.keymap.set("n", "<c-e>", "$")
vim.keymap.set("i", "<c-a>", "<c-o>^")
vim.keymap.set("i", "<c-e>", "<c-o>$")
vim.keymap.set("i", "<c-l>", '<c-o>"_dW')

-- swap between files
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- stop yanking my crank man
vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "C", '"_C')
vim.keymap.set({ "n", "v" }, "s", '"_s')
vim.keymap.set("n", "S", '"_S') -- capital S in visual mode is for surround

-- remap brackets (i know it's weird)
vim.keymap.set({ "n", "v" }, ")", "f)")
vim.keymap.set({ "n", "v" }, "(", "F(")

-- handy common things to type
vim.keymap.set("i", "<leader>c", "console.log(")
vim.keymap.set("i", "<leader>d", "debugger;<esc>")

----------------------------------------
-- plugins
----------------------------------------
vim.keymap.set("n", "<leader>r", ":NERDTreeFind<cr>")

-- commands
vim.cmd [[
    command! VR e ~/.config/nvim/lua/general.lua
    command! VL e ~/.config/nvim/lua/lsp.lua
    command! VT e ~/.tmux.conf
    command! VZ e ~/.zshrc
    command! QQ q!
]]

vim.cmd [[
    let NERDTreeIgnore = ['\.pyc$', '__pycache__']
    let NERDTreeNaturalSort = 1
    let NERDTreeCaseSensitiveSort = 1
    let g:NERDTreeWinSize=50

    set clipboard=unnamed "use system clipboard as unnamed register
    set nowrap

    set mouse=
]]
