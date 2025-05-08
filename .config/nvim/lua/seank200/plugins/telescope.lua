return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          n = {
            ["q"] = actions.close,
          },
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<ESC>"] = actions.close,
          },
        }
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap
    keymap.set("n", "<leader><space>", "<cmd>Telescope find_files<CR>",
      { desc = "Search for a file in cwd", noremap = true })
    keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<CR>",
      { desc = "Search string in files in cwd", noremap = true })
    keymap.set("n", "<leader>tg", "<cmd>Telescope grep_string<CR>",
      { desc = "Search for the word under the cursor in cwd", noremap = true })
    keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<CR>", { desc = "Search for open buffers", noremap = true })
    keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Search for todo comments", noremap = true })
  end
}
