""""""""""""""""""""""""""""
"       VIMRC              "
""""""""""""""""""""""""""""

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
" Initialize plugin system
call plug#end()

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Powerline
let g:powerline_pycmd="py3"
set laststatus=2

syntax enable
set background=dark
colorscheme solarized

