-- Keymaps that do not require plugins

vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ss', ':split<CR>', opts)
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', opts)
vim.keymap.set('i', 'jk', '<ESC>', opts)

