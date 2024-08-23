return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    local treesitter_context = require("treesitter-context")
    local ts_autotag = require("nvim-ts-autotag")

    treesitter.setup({
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      indent = {
        enable = true,
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },

      -- plugin nvim-ts-autotag
      autotag = {
        enable = true,
      }
    })

    treesitter_context.setup({
      enable = true,
      max_lines = 4,
      min_window_height = 20,
      mode = 'cursor',
    })
  end
}
