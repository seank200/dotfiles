local config = {}

config.mini = function()
	require("mini.bufremove").setup()

	--- Delete the current buffer using mini.bufremove
	local function delete_buf()
		MiniBufremove.delete(vim.api.nvim_get_current_buf())
	end

	local function delete_buf_force()
		MiniBufremove.delete(vim.api.nvim_get_current_buf(), true)
	end

	vim.keymap.set("n", "<leader>bd", delete_buf, { noremap = true })
	vim.keymap.set("n", "<leader>bD", delete_buf_force, { noremap = true })

	require("mini.comment").setup({
		options = {
			custom_commentstring = function()
				return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	})

	require("mini.pairs").setup()

	require("mini.surround").setup({
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "gsr",
			update_n_lines = "gsn",
		},
	})
end

config.ts_context_commentstring = function()
	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})
end

config.undo_tree = function()
	vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

	vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
	vim.opt.undofile = true
end

return config
