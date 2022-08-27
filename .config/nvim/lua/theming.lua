-- lualine = the stuff at the bottom
require("lualine").setup({
    sections = {
        lualine_c = {
            {
                "filename",
                file_status = true, -- Displays file status (readonly status, modified status)
                path = 2, -- Absolute path
                symbols = {
                    modified = "[+]", -- Text to show when the file is fmodified.
                    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                },
            },
        },
    },
    inactive_sections = {
        lualine_c = {
            {
                "filename",
                file_status = true,
                path = 2,
                symbols = {
                    modified = "[+]",
                    readonly = "[-]",
                    unnamed = "[No Name]",
                },
            },
        },
    },
})

-- This doesn't seem to be needed:
-- vim.opt.termguicolors = true

vim.cmd("colorscheme nightfox")
local palette = require("nightfox.palette").load("duskfox")

-- bufferline = tabs for buffers at the top
require("bufferline").setup({
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        max_name_length = 25,
        separator_style = "padded_slant",
    },
    highlights = {
        fill = {
            bg = "#000000",
        },
        separator_selected = {
            fg = "#000000",
            -- we can do stuff like this here:
            -- fg = palette.bg3,
            bg = normal_bg,
        },
        separator_visible = {
            fg = "#000000",
            bg = normal_bg,
        },
        separator = {
            fg = "#000000",
            bg = normal_bg,
        },
    },
})
