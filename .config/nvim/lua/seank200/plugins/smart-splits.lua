return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  config = function()
    local smart_splits = require("smart-splits")

    smart_splits.setup({
      ignored_filetypes = { "NvimTree" },
      default_amount = 5,
      at_edge = "stop"
    })

    vim.keymap.set('n', '<A-h>', smart_splits.resize_left, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-j>', smart_splits.resize_down, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-k>', smart_splits.resize_up, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-l>', smart_splits.resize_right, { noremap = true, silent = true })

    vim.keymap.set('n', '<A-H>', function() smart_splits.resize_left(1) end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-J>', function() smart_splits.resize_down(1) end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-K>', function() smart_splits.resize_up(1) end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-L>', function() smart_splits.resize_right(1) end, { noremap = true, silent = true })
  end
}
