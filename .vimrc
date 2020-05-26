""""""""""""""""""""""""""""
"       VIMRC              "
""""""""""""""""""""""""""""

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'janko/vim-test'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Initialize plugin system
call plug#end()

" General settings
set nocompatible
filetype plugin on
syntax on
let mapleader=","
set updatetime=100
set splitright
set nu
set rnu

" Search
set incsearch
set ignorecase
set hlsearch

" Colors
set background=dark
colorscheme solarized
" Fix issue with spell check underline on terminal
set t_Cs=

" Indentation
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType xml setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType java setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType sh setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType go setlocal shiftwidth=4 softtabstop=4 expandtab


" Powerline
let g:powerline_pycmd="py3"
set laststatus=2

" Java configurations
let $JAVA_TOOL_OPTIONS .= '-javaagent:/home/werbth/tools/lombok.jar -Xbootclasspath/p:/home/werbth/tools/lombok.jar'

set wildignore+=*/target/*

"""""""""""""""""""""""""""""""""
"       KEY MAPPINGS            "
"""""""""""""""""""""""""""""""""

" Clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

" Close preview buffers
noremap <Leader>c :pc<CR>

" vim-test mappings
nmap <silent> <Leader>n :TestNearest<CR>
nmap <silent> <Leader>f :TestFile<CR>
nmap <silent> <Leader>s :TestSuite<CR>
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>g :TestVisit<CR>

" Execute the current open file and show output in a split buffer
noremap <Leader>r :Dispatch %<CR>

"""""""""""""""""""""""""""""""""
"       PLUGINS                 "
"""""""""""""""""""""""""""""""""

" NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-h> :NERDTreeFind<CR>

" vim-test
let test#strategy = "dispatch"
let test#java#maventest#options = '-Dcheckstyle.skip -Dpmd.skip -Dcpd.skip -Dspotbugs.skip'

" vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" fzf
map <C-p> :Files<CR>

" Ycm
map <Leader>gd :YcmCompleter GoToDefinition<CR>

