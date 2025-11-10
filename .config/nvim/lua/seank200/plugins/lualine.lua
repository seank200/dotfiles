local section_logo = {
    function()
        return ""
    end,
    padding = 1,
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

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
          lualine_a = {},
          lualine_b = { section_logo },
          lualine_c = { section_filename, "diagnostics", "diff" },
          lualine_x = { "selection", "progress", "location" },
          lualine_y = { section_branch },
          lualine_z = {},
      },
      inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { section_filename },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
      },
  }
}
