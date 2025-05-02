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
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      ensure_installed = {
        "c",
        "python",
        "java",
        "javascript",
        "json",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "sql",
        "typescript",
        "yaml"
      },

      sync_install = false,  -- install "ensure_installed" synchronously

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
