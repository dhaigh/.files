-- https://github.com/nvimtools/none-ls.nvim
local null_ls = require "null-ls"

null_ls.setup {
    debug = true,
    sources = {
        null_ls.builtins.formatting.stylua,
    },
    on_attach = function(client, bufnr)
        if client:supports_method "textDocument/formatting" then
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
