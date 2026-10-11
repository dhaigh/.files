----------------------------------------
-- options
----------------------------------------

vim.cmd "colorscheme duskfox"

vim.opt.termguicolors = true -- 24-bit colour

vim.opt.expandtab = true -- <tab> produces spaces
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamed" -- use system clipboard as unnamed register
vim.opt.wrap = false
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.ftplugin_sql_omni_key = "<c-j>"

----------------------------------------
-- key bindings
----------------------------------------
-- use vim.keymap instead of nvim_set_keymap
-- https://www.reddit.com/r/neovim/comments/uuh8xw/comment/i9g59nx/?utm_source=reddit&utm_medium=web2x&context=3

-- the all important
vim.keymap.set("i", "<c-c>", "<esc>")
vim.keymap.set("i", "<s-tab>", "<esc>")

-- window navigation
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- paragraph navigation
vim.keymap.set({ "n", "v" }, "<c-j>", "}")
vim.keymap.set({ "n", "v" }, "<c-k>", "{")

-- buffers
vim.keymap.set("n", "<tab>", ":bn<cr>")
vim.keymap.set("n", "<s-tab>", ":bp<cr>")
vim.keymap.set("n", "<leader>q", ":bp|bd#<cr>")
vim.keymap.set("n", "<leader>b", ":bufdo bd<cr>")

-- ergonomics (- is next to 0)
vim.keymap.set("n", "-", "$")
vim.keymap.set("v", "-", "$h")

-- ergonomics ($ is next to #)
vim.keymap.set("n", "$", "*")

-- clear highlight
vim.keymap.set("n", "<c-n>", ":noh<cr>")

-- wholesome emacsy bindings
vim.keymap.set("i", "<c-a>", "<c-o>^")
vim.keymap.set("i", "<c-e>", "<c-o>$")
vim.keymap.set("i", "<c-l>", '<c-o>"_dw')

-- swap between files
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- <c-g> shows file info as normal; a second <c-g> within 500ms
-- copies the current file path to the system clipboard
local last_ctrl_g = 0
vim.keymap.set("n", "<c-g>", function()
    local now = (vim.uv or vim.loop).now()
    if now - last_ctrl_g < 500 then
        local path = vim.fn.expand "%"
        vim.fn.setreg("+", path)
        vim.notify("copied: " .. path)
        last_ctrl_g = 0
    else
        last_ctrl_g = now
        vim.cmd.file() -- same output as builtin <c-g>
    end
end)

-- preserve paste register when pasting over visual selection
vim.keymap.set("v", "p", '"_dP')

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
-- commands
----------------------------------------

vim.cmd [[
    command! VR e ~/.config/nvim/lua/general.lua
    command! VL e ~/.config/nvim/lua/lsp.lua
    command! VT e ~/.tmux.conf
    command! VZ e ~/.zshrc
    command! QQ q!
    command! QA qa!
    command! W w
    command! Wq wq
    command! WQ wq
    command! LR lsp restart
    command! LH checkhealth vim.lsp
]]

----------------------------------------
-- autocmds
----------------------------------------

-- re-source nvim config files on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "**/.config/nvim/**/*.lua" },
    group = vim.api.nvim_create_augroup("reload lua config", {}),
    callback = function(opts)
        vim.notify("Loaded " .. opts.file)
        dofile(opts.file)
    end,
})
