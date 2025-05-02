return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({})

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "vimls",
        "jsonls",
        "yamlls",
        "lua_ls",
        "ts_ls",
        "pyright",
      }
    })
  end,
}
