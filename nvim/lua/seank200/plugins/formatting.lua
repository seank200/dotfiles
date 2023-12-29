local config = {}

config.conform = function()
    require("conform").setup({
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            lua = { "stylua" },
            -- Use a sub-list to run only the first available formatter
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
        },
        -- Set up format-on-save autocmd
        -- This function is called on `BufWritePre`.
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,

        notify_on_error = true,
    })

    vim.api.nvim_create_user_command("FormatStop", function(args)
        if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
            print("Auto-format on save is disabled for this buffer.")
        else
            vim.g.disable_autoformat = true
            print("Auto-format on save is disabled.")
        end
    end, {
        desc = "Disable formatting on save",
        bang = true,
    })

    vim.api.nvim_create_user_command("FormatStart", function(args)
        if args.bang then
            vim.b.disable_autoformat = false
            print("Auto-format on save is enabled for this buffer.")
        else
            vim.g.disable_autoformat = false
            print("Auto-format on save is enabled.")
        end
    end, {
        desc = "Enable formatting on save",
        bang = true,
    })
end

return config
