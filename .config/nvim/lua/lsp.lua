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

local null_ls = require "null-ls"
local nvim_lsp = require "lspconfig"
local cmp = require "cmp"

--------------------------------------------------------------------------------
-- https://github.com/nvimtools/none-ls.nvim
null_ls.setup {
    debug = true,
    sources = {
        null_ls.builtins.formatting.stylua,
    },
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { bufnr = bufnr }
                end,
            })
        end
    end,
}

nvim_lsp.rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                command = "clippy",
            },
        },
    },
    on_attach = function(client, bufnr)
        -- Enable formatting if supported
        if client.server_capabilities.documentFormattingProvider then
            print "formatting enabled"
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { async = false }
                end,
            })
        end
    end,
}

--------------------------------------------------------------------------------
-- https://github.com/hrsh7th/nvim-cmp
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

--------------------------------------------------------------------------------
-- jose-elias-alvarez/typescript.nvim
-- require("nvim-lsp-installer").setup {}
-- https://docs.deno.com/runtime/getting_started/setup_your_environment/#neovim-0.6%2B-using-the-built-in-language-server
nvim_lsp.denols.setup {
    -- on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

nvim_lsp.ts_ls.setup {
    -- disable_commands = false,
    -- debug = true,
    server = {
        on_attach = function(client, bufnr)
            client.stop()
            for _, cl in pairs(vim.lsp.buf_get_clients()) do
                if cl.name == "denols" then
                    print "deno is running"
                end
            end
            -- client.server_capabilities.document_formatting = false
            -- client.server_capabilities.document_range_formatting = false
        end,
    },
    root_dir = nvim_lsp.util.root_pattern "package.json",
    single_file_support = false,
}

-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- nvim_lsp["tsserver"].setup {
--     -- cmd = { "yarn", "typescript-language-server", "--stdio" },
--     capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         -- if denols is running, disable tsserver for this buffer
--     end,
-- }

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

-- nvim_lsp.ts_ls.setup {
--     on_attach = on_attach,
--     root_dir = nvim_lsp.util.root_pattern "package.json",
--     single_file_support = false,
-- }
