local config = {}
local opts = { noremap = true, silent = true }

config.neo_tree = function()
    local command = require("neo-tree.command")

    require("neo-tree").setup({
        close_if_last_window = false,
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
            hijack_netrw_behavior = "open_current",
        },
        default_component_configs = {
            git_status = {
                symbols = {
                    added = "A",
                    deleted = "D",
                    modified = "M",
                    renamed = "R",
                    untracked = "U",
                    ignored = "-",
                    unstaged = "",
                    staged = "+",
                    conflict = "!",
                },
            },
        },
    })

    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵 ", texthl = "DiagnosticSignHint" })

    vim.keymap.set("n", "<leader>e", function()
        command.execute({ toggle = true })
    end)
    vim.keymap.set("n", "<leader>be", function()
        command.execute({ source = "buffers", toggle = true })
    end)
    vim.keymap.set("n", "<leader>ge", function()
        command.execute({ source = "git_status", toggle = true })
    end)
end

config.gitsigns = function()
    require("gitsigns").setup({
        update_debounce = 200,
    })

    vim.keymap.set("n", "<leader>bl", "<cmd>Gitsigns toggle_current_line_blame<CR>", { noremap = true })
end

config.illuminate = function()
    require("illuminate").configure({
        delay = 500,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
    })
end

config.trouble = function()
    require("trouble").setup({
        use_diagnostic_signs = true,
    })
    vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
end

config.todo_comments = function()
    require("todo-comments").setup({
        signs = false,
    })
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", opts)
end

config.bufferline = function()
    require("bufferline").setup({
        options = {
            show_close_icon = false,
            show_buffer_close_icons = false,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Explorer",
                    text_align = "center",
                    separator = true,
                },
            },
        },
    })
    vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", opts)
    vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", opts)
    vim.keymap.set("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", opts)
end

config.dashboard = function()
    local header = [[
                              ______ _____________________
    __________________ __________  //_/_|__ \_  __ \_  __ \
    __  ___/  _ \  __ `/_  __ \_  ,<  ____/ /  / / /  / / /
    _(__  )/  __/ /_/ /_  / / /  /| | _  __// /_/ // /_/ /
    /____/ \___/\__,_/ /_/ /_//_/ |_| /____/\____/ \____/
    ]]
    header = string.rep("\n", 2) .. header .. "\n"
    header = header .. os.date("%A, %B %d, %Y") .. string.rep("\n", 2)

    require("dashboard").setup({
        theme = "hyper",
        shortcut_type = "number",
        hide = {
            statusline = false,
        },
        config = {
            header = vim.split(header, "\n"),
            shortcut = {
                { icon = " ", desc = "Files", key = "f", action = "Telescope find_files", group = "String" },
                { icon = "󱎸 ", desc = "Grep", key = "g", action = "Telescope live_grep", group = "Constant" },
                {
                    icon = " ",
                    desc = "Restore",
                    key = "s",
                    action = "lua require('persistence').load()",
                    group = "Character",
                },
                {
                    icon = "󰊢 ",
                    desc = "Diff",
                    key = "d",
                    action = "DiffviewOpen",
                    group = "Type",
                },
                {
                    icon = "󰀖 ",
                    desc = "Config",
                    key = "c",
                    action = "lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })",
                    group = "Statement",
                },
                { icon = " ", desc = "Quit", key = "q", group = "Error", action = "qa" },
            },
            project = { enable = false },
            mru = {
                limit = 8,
                cwd_only = true,
            },
            footer = {
                "",
                "",
                "☕️ A pot of coffee, 12 jammy dodgers and a fez!",
            },
        },
    })
end

config.lualine = function()
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
            modified = "[+]",      -- Text to show when the file is modified.
            readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]",     -- Text to show for newly created file before first write
        },
    }

    local section_branch = {
        "branch",
        icon = "",
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
            lualine_y = {},
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

return config
