return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        offsets = {
          filetype = "NvimTree",
          text = "Explorer",
          text_align = "center",
          separator = true
        }
      },
    })

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", opts)
    keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", opts)
    keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", opts)
  end
}
