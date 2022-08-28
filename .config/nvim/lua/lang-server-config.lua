local on_attach = function(client, bufnr)
    local buf_map = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {})
    end

    vim.cmd "command! LspDef lua vim.lsp.buf.definition()"
    vim.cmd "command! LspFormatting lua vim.lsp.buf.formatting()"
    vim.cmd "command! LspCodeAction lua vim.lsp.buf.code_action()"
    vim.cmd "command! LspHover lua vim.lsp.buf.hover()"
    vim.cmd "command! LspRename lua vim.lsp.buf.rename()"
    vim.cmd "command! LspRefs lua vim.lsp.buf.references()"
    vim.cmd "command! LspTypeDef lua vim.lsp.buf.type_definition()"
    vim.cmd "command! LspImplementation lua vim.lsp.buf.implementation()"
    vim.cmd "command! LspDiagPrev lua vim.diagnostic.goto_prev()"
    vim.cmd "command! LspDiagNext lua vim.diagnostic.goto_next()"
    vim.cmd "command! LspDiagLine lua vim.diagnostic.open_float()"
    vim.cmd "command! LspSignatureHelp lua vim.lsp.buf.signature_help()"
    buf_map("n", "gd", ":LspDef<CR>")
    buf_map("n", "gr", ":LspRename<CR>")
    buf_map("n", "ge", ":LspRefs<CR>")
    buf_map("n", "gy", ":LspTypeDef<CR>")
    buf_map("n", "K", ":LspHover<CR>")
    buf_map("n", "[a", ":LspDiagPrev<CR>")
    buf_map("n", "]a", ":LspDiagNext<CR>")
    buf_map("n", "ga", ":LspCodeAction<CR>")
    buf_map("n", "<Leader>a", ":LspDiagLine<CR>")
    buf_map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

    if client.resolved_capabilities.document_formatting then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    end
end

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
    on_attach = on_attach,
}
