return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                           __  ___   ____  ____  ",
			"    ________  ____ _____  / /_|__ \\ / __ \\/ __ \\ ",
			"   / ___/ _ \\/ __ `/ __ \\/ //_/_/ // / / / / / / ",
			"  (__  )  __/ /_/ / / / / ,< / __// /_/ / /_/ /  ",
			" /____/\\___/\\__,_/_/ /_/_/|_/____/\\____/\\____/   ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", "<cmd>ene<CR>"),
			dashboard.button("e", "  File explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("f", "󰱼  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("g", "  Find in files", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("r", "󰁯  Restore session", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
		}

		dashboard.section.footer.val = "🚀 Twelve jammie dodgers and a fez!"

		alpha.setup(dashboard.opts)

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
