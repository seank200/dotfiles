local config = {}
local opts = { noremap = true, silent = true }

config.vim_tmux_navigator = function()
	vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
	vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
	vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
	vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
end

config.smart_splits = function()
	local smart_splits = require("smart-splits")

	smart_splits.setup({
		default_amount = 3,
		ignored_buftypes = { "neo-tree", "Telescope" },
		at_edge = "stop",
	})

	vim.keymap.set("n", "<A-h>", smart_splits.resize_left, opts)
	vim.keymap.set("n", "<A-j>", smart_splits.resize_down, opts)
	vim.keymap.set("n", "<A-k>", smart_splits.resize_up, opts)
	vim.keymap.set("n", "<A-l>", smart_splits.resize_right, opts)
	vim.keymap.set("n", "<M-h>", smart_splits.resize_left, opts)
	vim.keymap.set("n", "<M-j>", smart_splits.resize_down, opts)
	vim.keymap.set("n", "<M-k>", smart_splits.resize_up, opts)
	vim.keymap.set("n", "<M-l>", smart_splits.resize_right, opts)
end

config.telescope = function()
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")

	require("telescope").setup({
		defaults = {
			mappings = {
				-- normal mode mappings
				n = {
					-- close telescope
					["q"] = actions.close,
				},
			},
		},
		extensions = {
			file_browser = {
				grouped = true,
			},
		},
	})

	vim.keymap.set("n", "<leader><space>", builtin.find_files, opts)
	vim.keymap.set("n", "<leader>ff", builtin.git_files, opts)
	vim.keymap.set("n", "<leader>/", builtin.live_grep, opts)
	vim.keymap.set("n", "<leader>fr", builtin.oldfiles, opts)
	vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
end

config.telescope_file_browser = function()
	require("telescope").load_extension("file_browser")
	vim.keymap.set("n", "<leader>fd", "<cmd>Telescope file_browser<CR>", opts)
end

config.telescope_fzf = function()
	require("telescope").load_extension("fzf")
end

config.diffview = function()
    local actions = require("diffview.actions")
	require("diffview").setup({
        keymaps = {
            view = {
                { 'n', '<leader>e', actions.toggle_files, { desc = "Toggle the file panel."} },
                { 'n', 'gl', actions.cycle_layout, { desc = "Cycle through available layouts."} },
                { 'n', 'q', actions.close, { desc = "Close Diffview tab" } },
            },
            file_panel = {
                { 'n', '<leader>e', actions.toggle_files, { desc = "Toggle the file panel."} },
                { 'n', 'q', actions.close, { desc = "Close Diffview tab" } },
            },
            file_history_panel = {
                { 'n', '<leader>e', actions.toggle_files, { desc = "Toggle the file panel."} },
                { 'n', 'q', actions.close, { desc = "Close Diffview tab" } },
            },
        }
    })

    vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen<CR>", opts)
    vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", opts)
    vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", opts)

end

return config
