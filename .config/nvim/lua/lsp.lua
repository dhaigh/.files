--------------------------------------------------------------------------------
-- key bindings

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.rename)
vim.keymap.set("n", "ge", vim.lsp.buf.references)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "[a", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]a", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>a", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>x", vim.lsp.buf.signature_help)

--------------------------------------------------------------------------------
-- jose-elias-alvarez/typescript.nvim
require("nvim-lsp-installer").setup {}
require("typescript").setup {
    disable_commands = false,
    debug = true,
    server = {
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
            -- on_attach(client, bufnr)
        end,
    },
}

--------------------------------------------------------------------------------
-- jose-elias-alvarez/null-ls.nvim
local null_ls = require "null-ls"
null_ls.setup {
    debug = true,
    sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.rustfmt,
    },
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            local group = vim.api.nvim_create_augroup("null-ls attach", {})
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                pattern = { "*.lua" },
                group = group,
                callback = function(opts)
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
}

--------------------------------------------------------------------------------
-- https://github.com/hrsh7th/nvim-cmp
local cmp = require "cmp"
cmp.setup {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert {
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    }),
}

--------------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig")["tsserver"].setup {
    -- cmd = { "yarn", "typescript-language-server", "--stdio" },
    capabilities = capabilities,
}

-- local status, ts = pcall(require, "nvim-treesitter.configs")
-- if not status then
--     return
-- end

-- ts.setup {
--     highlight = {
--         additional_vim_regex_highlighting = true,
--         custom_captures = {},
--         disable = {},
--         enable = false,
--         loaded = true,
--     },
--     indent = {
--         enable = true,
--         disable = {},
--     },
--     ensure_installed = {
--         "tsx",
--     },
-- }
--
--
-- solargraph (ruby)
--
local lspconfig = require "lspconfig"

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    }
end

local defaults = {}

lspconfig.solargraph.setup(vim.tbl_deep_extend("force", {
    settings = {
        Solargraph = {
            root_dir = lspconfig.util.root_pattern("Gemfile", ".git")(fname) or vim.fn.getcwd(),
        },
    },
}, defaults))
