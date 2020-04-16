""""""""""""""""""""""""""""
"       VIMRC              "
""""""""""""""""""""""""""""

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
" Initialize plugin system
call plug#end()

" General settings
set nocompatible
syntax enable
let mapleader=","
set updatetime=100

" Search
set incsearch
set hlsearch

noremap <Leader>y "+y
noremap <Leader>p "+p

" Colors
set background=dark
colorscheme solarized

" Indentation
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType xml setlocal shiftwidth=4 softtabstop=4 expandtab

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Powerline
let g:powerline_pycmd="py3"
set laststatus=2

" Fix issue with spell check underline on terminal
set t_Cs=
