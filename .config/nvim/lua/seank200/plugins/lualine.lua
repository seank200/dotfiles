return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local section_leftend = {
        function()
            return ""
        end,
        padding = 1,
    }

    local section_rightend = {
        function()
            if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
                if vim.o.columns > 60 then
                    local hostname = vim.fn.hostname()
                    if string.len(hostname) > 16 then
                        hostname = string.sub(hostname, 1, 14) .. ".."
                    end
                    return ' 󰑔 ' .. hostname .. ' '
                else
                    return ' 󰑔 '
                end
            end
            return ' '
        end,
        padding = 0,
    }

    local section_filetype = {
        "filetype",
        padding = { left = 1, right = 0 },
        colored = true,
        icon_only = true,
    }

    local section_filename = {
        "filename",
        path = 1,
        symbols = { 
            modified = "*",      -- Text to show when the file is modified.
            readonly = "",      -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]",     -- Text to show for newly created file before first write
        },
    }

    local section_branch = {
        "branch",
        icon = "",
    }

    local lazy_status = require("lazy.status")
    local section_lazy_status = {
      lazy_status.updates,
      cond = lazy_status.has_updates
    }

    require("lualine").setup({
        options = {
            component_separators = "",
            section_separators = "",
            disabled_filetypes = {
                statusline = {
                    "neo-tree",
                    "Telescope",
                },
            },
            globalstatus = false,
        },
        sections = {
            lualine_a = { section_leftend },
            lualine_b = {},
            lualine_c = { section_branch, section_filetype, section_filename, "diagnostics", "diff" },
            lualine_x = { "selection", "progress", "location" },
            lualine_y = { section_lazy_status },
            lualine_z = { section_rightend },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { section_filetype, section_filename },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
    })
  end
}
