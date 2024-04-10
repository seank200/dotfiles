return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = {
        "~/",
        "~/Downloads/",
        "~/Documents/",
        "~/Desktop/",
        "~/dev/",
      }
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>rr", "<cmd>SessionRestore<CR>", { desc = "Restore session" })
    keymap.set("n", "<leader>rs", "<cmd>SessionSave<CR>", { desc = "Save session" })
  end
}
