local function mason_config()
  require("mason").setup()
  require("mason-lspconfig").setup()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)

      if client == nil then
        return
      end

      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end

      -- Auto-format ("lint") on save.
      -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
      if not client:supports_method('textDocument/willSaveWaitUntil')
          and client:supports_method('textDocument/formatting') then
        -- vim.api.nvim_create_autocmd('BufWritePre', {
        --   buffer = ev.buf,
        --   callback = function()
        --     vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        --   end,
        -- })
        vim.keymap.set("n", "grf", function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
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
