--------------------------------------------------------------------------------
-- key bindings

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.rename)
vim.keymap.set("n", "ge", vim.lsp.buf.references)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "[a", function()
    vim.diagnostic.jump { count = -1, float = true }
end)
vim.keymap.set("n", "]a", function()
    vim.diagnostic.jump { count = 1, float = true }
end)
vim.keymap.set("n", "<leader>a", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>x", vim.lsp.buf.signature_help)

--------------------------------------------------------------------------------
-- rust
vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
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
})
vim.lsp.enable "rust_analyzer"

--------------------------------------------------------------------------------
-- ruby
vim.lsp.config("ruby_lsp", {
    cmd = { "/Users/deco/.local/bin/mise", "exec", "--", "ruby-lsp" },
    init_options = {
        addonSettings = {
            -- Key must match Addon#name in ruby-lsp-rails.
            ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
            },
        },
    },
})
vim.lsp.enable "ruby_lsp"

vim.lsp.config("sorbet", {
    cmd = { "/Users/deco/.local/bin/mise", "exec", "--", "bundle", "exec", "srb", "tc", "--lsp" },
})
vim.lsp.enable "sorbet"

--------------------------------------------------------------------------------
-- typescript
vim.lsp.config("ts_ls", {
    cmd = { "/Users/deco/.local/bin/mise", "exec", "--", "typescript-language-server", "--stdio" },
    single_file_support = false,
    before_init = function(params, config)
        -- TS 7 projects alias "typescript" to the @typescript/typescript6 shim, which
        -- has no tsserver.js; the real TS 6 server lives in @typescript/old.
        local tsserver = (config.root_dir or "") .. "/node_modules/@typescript/old/lib/tsserver.js"
        if vim.uv.fs_stat(tsserver) then
            params.initializationOptions = vim.tbl_deep_extend("force", params.initializationOptions or {}, {
                tsserver = { path = tsserver },
            })
        end
    end,
})
vim.lsp.enable "ts_ls"
