return {
  "nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    view = { width = 35 },
    renderer = {
      indent_markers = { enable = true },
    },
    actions = {
      open_file = { window_picker = { enable = false } }
    },
    filters = {
      custom = { ".DS_Store", "^\\.git" }
    },
    git = {
      ignore = false
    },
  }
}
