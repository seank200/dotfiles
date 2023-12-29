local config = {}

config.treesitter = function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "javascript",
      "typescript",
      "css",
      "html",
      "jsdoc",
      "json",
      "markdown",
      "bash",
      "csv",
      "c",
      "cpp",
      "cmake",
      "make",
      "diff",
      "gitignore",
      "latex",
      "lua",
      "python",
      "vim",
      "vimdoc",
      "query",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    indent = {
      enable = true,
    },

    highlight = {
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
end

config.treesitter_context = function()
  require("treesitter-context").setup({
    enable = true,
    max_lines = 4,
    min_window_height = 10,
    mode = 'cursor',
  })
end

config.ts_autotag = function()
  require("nvim-ts-autotag").setup()
end

return config
