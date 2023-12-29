" Basic config and remaps
" Intentionally written in vimscript for easily configuring vim
" in restricted (remote) environments

" Line numbers
set nu
set rnu

" Indents
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Wrapping
set wrap!

" Highlight
set hlsearch
set incsearch

set backspace 

" Colors
" set termguicolors

" Scrolling
set scrolloff=4

" Backspace options (for vim, mostly)
set backspace=indent,eol,start

" Basic key remaps
let g:mapleader = " "

" Split windows
nnoremap <leader>ss :split<cr>
nnoremap <leader>sv :vsplit<cr>

" Close buffers without closing editor
nnoremap <silent> <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>

" Tab Management
nnoremap <silent> <leader>te :tabedit<CR>
" nnoremap <silent> H :tabprev<CR>
" nnoremap <silent> L :tabnext<CR>

" Escape insert mode
inoremap jk <esc>

