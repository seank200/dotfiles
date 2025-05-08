local function mason_config()
  require("mason").setup()
  require("mason-lspconfig").setup()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)

      if client == nil then
        return
      end

      vim.b.format_on_save = false

      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end

      if not client:supports_method('textDocument/willSaveWaitUntil')
          and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = ev.buf,
          callback = function()
            if vim.b.format_on_save then
              vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
            end
          end,
        })

        -- Manually trigger linting
        vim.keymap.set("n", "<leader>f", function()
          print("Formatting using '" .. client.name .. "'...")
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
          print("Formatted using '" .. client.name .. "'.")
        end, { buffer = ev.buf })

        -- Toggle automatic linting
        vim.keymap.set("n", "<leader>F", function()
          local option = ""
          if vim.b.format_on_save then
            option = "disabled"
            vim.b.format_on_save = false
          else
            option = "enabled"
            vim.b.format_on_save = true
            vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
          end

          print("Format-on-save " .. option .. " (client: '" .. client.name .. "')")
        end, { buffer = ev.buf })
      end
    end,
  })
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = mason_config
}
