-- git change markers in the gutter, relative to master (like `git diff master...`)
--   <leader>gt  toggle the markers on/off
--   <leader>gm  re-resolve the merge base with master (after merging/rebasing master)
--   <leader>gi  diff against the index instead
--   <leader>gd  vimdiff the current buffer against the current base
--   ]c / [c     jump to next/previous hunk

local gs = require "gitsigns"

-- merge base of master and HEAD, for the repo containing the current
-- buffer (or nvim's cwd if the buffer has no file). gitsigns needs a
-- single revision, so `master...` itself can't be used as the base.
local function merge_base(quiet)
    local dir = vim.fn.expand "%:p:h"
    if dir == "" then
        dir = vim.fn.getcwd()
    end
    local out = vim.fn.systemlist { "git", "-C", dir, "merge-base", "master", "HEAD" }
    if vim.v.shell_error ~= 0 or out[1] == nil then
        if not quiet then
            vim.notify("gitsigns: could not find merge base with master", vim.log.levels.WARN)
        end
        return nil
    end
    return out[1]
end

-- nil (index) if we're not in a repo or there's no master
gs.setup { base = merge_base(true) }

vim.keymap.set("n", "<leader>gt", gs.toggle_signs)
vim.keymap.set("n", "<leader>gm", function()
    local base = merge_base()
    if base then
        gs.change_base(base, true)
    end
end)
vim.keymap.set("n", "<leader>gi", function()
    gs.change_base(nil, true)
end)
vim.keymap.set("n", "<leader>gd", gs.diffthis)
vim.keymap.set("n", "]c", gs.next_hunk)
vim.keymap.set("n", "[c", gs.prev_hunk)
