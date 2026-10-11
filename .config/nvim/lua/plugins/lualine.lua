-- lualine = the stuff at the bottom
require("lualine").setup {
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
}
