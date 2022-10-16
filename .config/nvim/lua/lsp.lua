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
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
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
