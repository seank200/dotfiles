local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>ss", "<C-w>s", { desc = "Split window vertically" })
keymap.set("n", "<leader>bd", "<cmd>bp|bd #<CR>", { desc = "Close current buffer", remap = false, silent = true })

-- Plugins
keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle directory tree (select current)" })


