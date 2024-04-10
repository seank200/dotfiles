return {
  "christoomey/vim-tmux-navigator",
  config = function()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
    keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
    keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
    keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
  end
}

