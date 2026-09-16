-- Send a visual selection to a fresh Claude Code session.
-- Usage: select lines, then :claude explain these lines
-- Each invocation opens a new terminal split with a brand-new claude session.

vim.api.nvim_create_user_command("Claude", function(opts)
    local prompt = opts.args ~= "" and opts.args or "explain these lines"
    local parts = { prompt }

    if opts.range > 0 then
        local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
        local file = vim.fn.expand "%:."
        table.insert(parts, string.format(
            "%s lines %d-%d:\n```%s\n%s\n```",
            file, opts.line1, opts.line2, vim.bo.filetype, table.concat(lines, "\n")
        ))
    end

    vim.cmd "botright vnew"
    vim.fn.jobstart({ "claude", table.concat(parts, "\n\n") }, { term = true })
    vim.cmd "startinsert"
end, { range = true, nargs = "*", desc = "Send selection to a new Claude Code session" })

-- let :claude (and :'<,'>claude) work lowercase
vim.keymap.set("ca", "claude", function()
    if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline():match "^[%p%d]*claude$" then
        return "Claude"
    end
    return "claude"
end, { expr = true })
