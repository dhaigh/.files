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
vim.keymap.set("n", "<c-x><c-x>", vim.lsp.buf.signature_help)

--------------------------------------------------------------------------------
-- jose-elias-alvarez/typescript.nvim
require("typescript").setup {
    disable_commands = false,
    debug = true,
    server = {
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
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
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig")["tsserver"].setup {
    capabilities = capabilities,
}
