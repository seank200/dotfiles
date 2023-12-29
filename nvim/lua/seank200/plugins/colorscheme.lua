local config = {}

config.catppuccin = function ()
    require("catppuccin").setup {
        transparent_background = true,
    }

    vim.cmd.colorscheme "catppuccin-mocha"
end

return config
