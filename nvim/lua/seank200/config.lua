-- Line numbering
vim.opt.nu = true
vim.opt.rnu = true

-- Indents
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.cmd [[ autocmd FileType c setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd FileType cpp setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd FileType python setlocal sw=4 ts=4 ]]


vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4

vim.opt.colorcolumn = "80"
