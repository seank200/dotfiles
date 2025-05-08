local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2        -- N spaces for tabs
opt.shiftwidth = 2     -- N spaces for indent width
opt.expandtab = true   -- expand tab to spaces

vim.cmd [[ autocmd Filetype c setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd Filetype cpp setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd Filetype python setlocal sw=4 ts=4 ]]

opt.wrap = false
opt.linebreak = false
opt.scrolloff = 4  -- Keep N lines above/below the cursor

opt.ignorecase = true
opt.smartcase = true  -- case-sensitive when query contains mixed cases

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

opt.colorcolumn = "80"

opt.completeopt = "menuone,popup,noinsert"

vim.cmd.colorscheme "catppuccin"
