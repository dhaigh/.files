-- Run tsc and list the files with type errors in a scratch split.
-- Usage: :tsc  (from the project root)
-- <cr> on a line opens that file in the previous window.

local BUF_NAME = "tsc-errors"

local function show(files)
    local buf = vim.fn.bufnr(BUF_NAME)
    if buf == -1 then
        buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_buf_set_name(buf, BUF_NAME)
        vim.bo[buf].bufhidden = "hide"
        vim.keymap.set("n", "<cr>", function()
            local file = vim.api.nvim_get_current_line()
            if file == "" then return end
            vim.cmd "wincmd p"
            vim.cmd.edit(vim.fn.fnameescape(file))
        end, { buffer = buf })
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

    local win = vim.fn.bufwinid(buf)
    if win == -1 then
        vim.cmd("botright sbuffer " .. buf)
        vim.api.nvim_win_set_height(0, math.min(#files, 15))
    else
        vim.api.nvim_set_current_win(win)
    end
end

vim.api.nvim_create_user_command("Tsc", function()
    -- the project's own tsc if installed, else whatever's on PATH
    -- (not npx: without a local typescript it fetches npm's unrelated "tsc" package)
    local local_tsc = "node_modules/.bin/tsc"
    local tsc = vim.fn.executable(local_tsc) == 1 and local_tsc or "tsc"
    if vim.fn.executable(tsc) == 0 then
        vim.notify("tsc: not found", vim.log.levels.ERROR)
        return
    end

    vim.notify "tsc: running…"
    vim.system({ tsc, "--noEmit", "--pretty", "false" }, { text = true }, function(res)
        vim.schedule(function()
            local out = (res.stdout or "") .. (res.stderr or "")
            local seen, files = {}, {}
            for line in out:gmatch "[^\n]+" do
                local file = line:match "^(.-)%(%d+,%d+%): error"
                if file and not seen[file] then
                    seen[file] = true
                    table.insert(files, file)
                end
            end
            table.sort(files)

            if #files > 0 then
                show(files)
                vim.notify(string.format("tsc: %d files with errors", #files))
            elseif res.code == 0 then
                vim.notify "tsc: no errors"
            else
                vim.notify("tsc failed:\n" .. out:sub(1, 500), vim.log.levels.ERROR)
            end
        end)
    end)
end, { desc = "List files with TypeScript errors" })

-- let :tsc work lowercase
vim.keymap.set("ca", "tsc", function()
    if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "tsc" then
        return "Tsc"
    end
    return "tsc"
end, { expr = true })
