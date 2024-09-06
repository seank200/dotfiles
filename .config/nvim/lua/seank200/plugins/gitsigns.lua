return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function keymap(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- navigation
			keymap("n", "]h", gs.next_hunk, "Go to next hunk")
			keymap("n", "[h", gs.prev_hunk, "Go to previous hunk")
		end,
	},
}
