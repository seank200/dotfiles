return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open/close trouble list" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>",    desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",     desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>",        desc = "Open todos in trouble" },
  },
}
