---@param package_names string[] Array of Mason package names
---@return nil
local function mason_ensure_installed(package_names)
  local registry = require("mason-registry")

  -- Key: required package name
  -- Value: false (not installed)
  local required_status = {}
  for _, required_name in pairs(package_names) do
    required_status[required_name] = false
  end

  -- Key: installed package name
  -- Value: true (installed)
  local installed_names = registry.get_installed_package_names()
  for _, installed_name in pairs(installed_names) do
    required_status[installed_name] = true
  end

  local is_install_cmd_required = false
  local install_cmd = "MasonInstall"
  for required_name, is_installed in pairs(required_status) do
    if not is_installed then
      is_install_cmd_required = true
      install_cmd = install_cmd .. " " .. required_name
    end
  end

  if is_install_cmd_required then
    vim.cmd(install_cmd)
  end
end

local function mason_config()
  require("mason").setup()
  mason_ensure_installed({
    "bash-language-server",
    "lua-language-server",
    "json-lsp",
    "pylint",
    "vim-language-server",
    "yaml-language-server",
  })

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

        -- Manually trigger formatting
        vim.keymap.set("n", "<leader>f", function()
          print("Formatting using '" .. client.name .. "'...")
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
          print("Formatted using '" .. client.name .. "'.")
        end, { buffer = ev.buf, desc = "Format buffer (LSP)" })

        -- Toggle automatic formatting
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
        end, { buffer = ev.buf, desc = "Toggle format-on-save (LSP)" })
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
