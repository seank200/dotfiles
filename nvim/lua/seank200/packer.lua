local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

local config = {
    coding = require("seank200.plugins.coding"),
    colorscheme = require("seank200.plugins.colorscheme"),
    editor = require("seank200.plugins.editor"),
    formatting = require("seank200.plugins.formatting"),
    lsp = require("seank200.plugins.lsp"),
    treesitter = require("seank200.plugins.treesitter"),
    ui = require("seank200.plugins.ui"),
    utils = require("seank200.plugins.utils"),
}

return require("packer").startup({
    function(use)
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Coding
        use({
            "echasnovski/mini.nvim",
            branch = "stable",
            config = config.coding.mini,
        })
        use({
            "JoosepAlviste/nvim-ts-context-commentstring",
            config = config.coding.ts_context_commentstring,
        })
        use({
            "mbbill/undotree",
            config = config.coding.undo_tree,
        })
        use({ "markonm/traces.vim" })

        -- ColorSchemes
        use({
            "catppuccin/nvim",
            as = "catppuccin",
            config = config.colorscheme.catppuccin,
        })

        -- Editor
        use({
            "christoomey/vim-tmux-navigator",
            config = config.editor.vim_tmux_navigator,
        })
        use({
            "mrjones2014/smart-splits.nvim",
            config = config.editor.smart_splits,
        })
        use({
            "nvim-telescope/telescope.nvim",
            tag = "0.1.5",
            requires = {
                { "nvim-lua/plenary.nvim" },
            },
            config = config.editor.telescope,
        })
        use({
            "nvim-telescope/telescope-file-browser.nvim",
            requires = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
            },
            config = config.editor.telescope_file_browser,
        })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            requires = {
                "nvim-telescope/telescope.nvim",
            },
            config = config.editor.telescope_fzf,
        })
        use({ "nvim-pack/nvim-spectre" })
        use({
            "sindrets/diffview.nvim",
            config = config.editor.diffview,
        })

        -- Formatting
        use({
            "stevearc/conform.nvim",
            config = config.formatting.conform,
        })

        -- LSP
        use({
            "williamboman/mason.nvim",
            config = config.lsp.mason,
        })
        use({
            "williamboman/mason-lspconfig.nvim",
            after = { "mason.nvim" },
            requires = { { "williamboman/mason.nvim" } },
        })
        use({
            "VonHeikemen/lsp-zero.nvim",
            branch = "v3.x",
            after = { "mason-lspconfig.nvim" },
            requires = {
                --- Uncomment these if you want to manage LSP servers from neovim
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },

                -- LSP Support
                { "neovim/nvim-lspconfig" },

                -- Autocompletion
                { "hrsh7th/nvim-cmp" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-cmdline" },
                { "L3MON4D3/LuaSnip" },
            },
            config = config.lsp.lsp_zero,
        })
        use({
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup()
            end,
        })

        -- Treesitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = config.treesitter.treesitter,
        })
        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter",
        })
        use({
            "nvim-treesitter/nvim-treesitter-context",
            after = "nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter",
            config = config.treesitter.treesitter_context,
        })

        -- UI
        use({
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
                -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
            },
            config = config.ui.neo_tree,
        })
        use({ "nvim-tree/nvim-web-devicons" })
        use({
            "lewis6991/gitsigns.nvim",
            config = config.ui.gitsigns,
        })
        use({
            "RRethy/vim-illuminate",
            config = config.ui.illuminate,
        })
        use({
            "folke/trouble.nvim",
            requires = "nvim-tree/nvim-web-devicons",
            config = config.ui.trouble,
        })
        use({
            "folke/todo-comments.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = config.ui.todo_comments,
        })
        use({
            "akinsho/bufferline.nvim",
            tag = "*",
            requires = "nvim-tree/nvim-web-devicons",
            config = config.ui.bufferline,
        })
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "nvim-tree/nvim-web-devicons", opt = true },
            config = config.ui.lualine,
        })
        use({
            "nvimdev/dashboard-nvim",
            event = "VimEnter",
            requires = { "nvim-tree/nvim-web-devicons" },
            config = config.ui.dashboard,
        })

        -- Utils
        use({ "nvim-lua/plenary.nvim" })
        use({
            "folke/persistence.nvim",
            config = config.utils.persistence,
        })
        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
            ft = { 'markdown' },
        })

        -- Automatically install and configure if packer was first installed
        if packer_bootstrap then
            require("packer").sync()
        end
    end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        }
    }
})
