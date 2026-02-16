vim.g.mapleader = vim.keycode('<Space>')
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 4 -- Keep N lines above/below cursor
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.colorcolumn = "79"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.wrap = false

vim.cmd [[ autocmd Filetype c setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd Filetype cpp setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd Filetype python setlocal sw=4 ts=4 ]]
vim.cmd [[ autocmd FileType java setlocal cc=120 ]]

vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x' }, 'gp', '"+p', { desc = 'Paste clipboard content' })
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit INSERT mode' })

vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE') -- Non-focused buffer


local mini = {}

mini.branch = 'main'
mini.packpath = vim.fn.stdpath('data') .. '/site'

function mini.require_deps()
  local mini_path = mini.packpath .. '/pack/deps/start/mini.nvim'

  if not vim.uv.fs_stat(mini_path) then
    print('Installing mini.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/nvim-mini/mini.nvim',
      string.format('--branch=%s', mini.branch),
      mini_path
    })

    vim.cmd('packadd mini.nvim | helptags ALL')
  end

  local ok, deps = pcall(require, 'mini.deps')
  if not ok then
    return {}
  end

  return deps
end

local MiniDeps = mini.require_deps()
if not MiniDeps.setup then
  return
end


MiniDeps.setup({ path = { package = mini.packpath } })

MiniDeps.add({ source = 'catppuccin/nvim', name = 'catppuccin' })
vim.o.termguicolors = true
vim.cmd.colorscheme('catppuccin')

MiniDeps.add('folke/which-key.nvim')
MiniDeps.add('christoomey/vim-tmux-navigator')
MiniDeps.add('mrjones2014/smart-splits.nvim')
MiniDeps.add({
  source = 'mason-org/mason-lspconfig.nvim',
  depends = {
    'mason-org/mason.nvim',
    'neovim/nvim-lspconfig'
  }
})
MiniDeps.add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  hooks = {
    post_checkout = function()
      vim.cmd.TSUpdate()
    end,
  },
})
MiniDeps.add({
  source = 'nvim-mini/mini.nvim',
  checkout = mini.branch,
})


require('mini.icons').setup({ style = 'glyph' })

require('mini.surround').setup()

require('mini.comment').setup()

require('mini.extra').setup()

require('mini.bufremove').setup()
vim.keymap.set('n', '<leader>bc', '<cmd>lua pcall(MiniBufremove.delete)<cr>', { desc = 'Close buffer' })

local mini_files = require('mini.files')
mini_files.setup({})
vim.keymap.set('n', '<leader>e', function() -- See :help MiniFiles-navigation
  if mini_files.close() then
    return
  end

  mini_files.open()
end, { desc = 'File explorer' })

-- See :help MiniPick.config
require('mini.pick').setup()

-- See available pickers
-- :help MiniPick.builtin
-- :help MiniExtra.pickers
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', { desc = 'Search open files' })
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Search all files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Search in project' })
vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic<cr>', { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>fs', '<cmd>Pick buf_lines<cr>', { desc = 'Buffer local search' })

require('mini.diff').setup()

require('mini.snippets').setup({})

-- See :help MiniCompletion.config
require('mini.completion').setup({
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false,
  },
})

-- christoomey/vim-tmux-navigator
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>')
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>')

-- mrjones2014/smart-splits.nvim
local smart_splits = require('smart-splits')
smart_splits.setup({
  -- Ignored buffer types (only while resizing)
  ignored_buftypes = {
    'nofile',
    'quickfix',
    'prompt',
  },

  -- Ignored filetypes (only while resizing)
  ignored_filetypes = { 'NvimTree' },

  -- the default number of lines/columns to resize by at a time
  default_amount = 3,

  -- Desired behavior when your cursor is at an edge and you
  -- are moving towards that same edge:
  -- 'wrap' => Wrap to opposite side
  -- 'split' => Create a new split in the desired direction
  -- 'stop' => Do nothing
  at_edge = 'wrap',
})
vim.keymap.set('n', '<A-h>', smart_splits.resize_left)
vim.keymap.set('n', '<A-j>', smart_splits.resize_down)
vim.keymap.set('n', '<A-k>', smart_splits.resize_up)
vim.keymap.set('n', '<A-l>', smart_splits.resize_right)

-- Treesitter
-- Ensure tree-sitter CLI is available
-- See additional commands :help nvim-treesitter-commands
local treesitter_languages = {
  'c',
  'cpp',
  'dockerfile',
  'gitcommit',
  'gitignore',
  'groovy',
  'json',
  'lua',
  'markdown',
  'python',
  'zsh',
}

require('nvim-treesitter').install(treesitter_languages)

-- Enable highlighting
-- See :help treesitter-highlight
vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter_languages,
  callback = function() vim.treesitter.start() end,
})

-- LSP
require("mason").setup({})

require("mason-lspconfig").setup({})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)

    -- Completion
    if client and client:supports_method('textDocument/completion') then
      vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

      vim.cmd [[ inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>" ]]
      vim.cmd [[ inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" ]]
    end

    -- Formatting
    if client and not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      -- Format on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = event.buf,
        callback = function()
          if vim.b.format_on_save then
            vim.lsp.buf.format({
              bufnr = event.buf,
              id = client.id,
              timeout_ms = 3000
            })
          end
        end,
      })

      -- Manually trigger formatting
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({
          bufnr = event.buf,
          id = client.id,
          timeout_ms = 3000
        })
      end, { buffer = event.buf, desc = "Format buffer (LSP)" })

      -- Toggle automatic formatting
      vim.keymap.set("n", "<leader>F", function()
        local option = ""
        if vim.b.format_on_save then
          option = "off"
          vim.b.format_on_save = false
        else
          option = "on"
          vim.b.format_on_save = true
        end

        print("autoformat=" .. option .. " (using '" .. client.name .. "')")
      end, { buffer = event.buf, desc = "Toggle format-on-save (LSP)" })
    end
  end,
})
