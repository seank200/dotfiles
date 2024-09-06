return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      -- ui = {
      --   icons = {
      --     package_installed = "✓",
      --     package_pending = "➜",
      --     package_uninstalled = "✗",
      --   },
      -- },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "vimls",
        "jsonls",
        "yamlls",

        "html",
        "cssls",
        "tailwindcss",
        "emmet_language_server",
        "eslint",
        "lua_ls",

        -- `tsserver` is being renamed to `ts_ls` as of lsp 0.2.0
        -- Should modify after release
        "tsserver",
        "pyright",
      }
    })
  end,
}
