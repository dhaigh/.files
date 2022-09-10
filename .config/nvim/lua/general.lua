local group = vim.api.nvim_create_augroup("reload lua config", {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { ".config/nvim/**/*.lua" },
    callback = function(opts)
        dofile(opts.file)
        print("Loaded " .. opts.file)
    end,
    group = group,
})

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
vim.keymap.set("n", "<leader>d", ":bd<cr>")

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

-- swap between files
vim.keymap.set("n", "<leader><leader>", "<c-^>")
