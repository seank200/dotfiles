local config = {}

config.persistence = function ()
    local persistence = require("persistence")
    persistence.setup()
    vim.keymap.set('n', '<leader>qs', persistence.load, { noremap = true })
end

return config
