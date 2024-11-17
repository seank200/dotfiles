return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      -- format_on_save = {
      -- 	lsp_fallback = true,
      -- 	async = false,
      -- 	timeout_ms = 1000,
      -- },
      format_on_save = function(bufnr)
        if vim.g.disable_format_on_save or vim.b[bufnr].disable_format_on_save then
          return
        end

        return {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end
    })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_format_on_save = true
      else
        vim.g.disable_format_on_save = true
      end
    end, {
      desc = "Disable format-on-save (conform)",
      bang = true
    })

    vim.api.nvim_create_user_command("FormatEnable", function(args)
      vim.b.disable_format_on_save = false
      vim.g.disable_format_on_save = false
    end, { desc = "Enable format-on-save (conform)" })

    vim.keymap.set("n", "<leader>fd", "<cmd>FormatDisable<cr>", { desc = "Disable format-on-save", remap = false })
    vim.keymap.set("n", "<leader>fe", "<cmd>FormatEnable<cr>", { desc = "Enable format-on-save", remap = false })

    -- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    --   conform.format({
    --     lsp_fallback = true,
    --     async = false,
    --     timeout_ms = 1000,
    --   })
    -- end, { desc = "Format file or range (in visual mode)" })
  end,
}
