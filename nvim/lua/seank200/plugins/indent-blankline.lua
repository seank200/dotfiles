return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    enabled = true,
    debounce = 500,
    indent = {
      smart_indent_cap = true
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "NvimTree",
        "",
      },
    },
  }
}
