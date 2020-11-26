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
Plug 'vim-test/vim-test'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'maralla/validator.vim'
Plug 'ternjs/tern_for_vim', { 'do' : 'npm install' }
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

" Python
au FileType python setlocal
    \ tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    \ textwidth=79 autoindent cc=+1

" VimL Script
au FileType vim setlocal
    \ tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    \ textwidth=120 autoindent cc=+1

" Java
au FileType java setlocal
    \ tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    \ textwidth=120 autoindent cc=+1

" Markdown
au FileType markdown setlocal
    \ tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    \ textwidth=80 autoindent cc=+1

" yaml
au FileType yaml setlocal
    \ tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" json
au FileType json setlocal
    \ tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" xml
au FileType xml setlocal
    \ tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" sh
au FileType sh setlocal
    \ tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" go
au FileType go setlocal
    \ tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" javascript
au FileType javascript setlocal
    \ tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" html
au BufNewFile,BufRead *.html setlocal
    \ tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" sql
au BufNewFile,BufRead *.sql setlocal
    \ tabstop=2 softtabstop=2 shiftwidth=2 expandtab





" Powerline
let g:powerline_pycmd="py3"
set laststatus=2

" Java configurations
let $JAVA_TOOL_OPTIONS .= '-javaagent:/home/werbth/tools/lombok.jar -Xbootclasspath/p:/home/werbth/tools/lombok.jar'

set wildignore+=*/target/*

"""""""""""""""""""""""""""""""""
"       KEY MAPPINGS            "
"""""""""""""""""""""""""""""""""

" Save
noremap <Leader>w :update<CR>

" Format current file
execute "set <M-b>=\eb"
noremap <M-b> :Neoformat<CR>

" Open terminal
noremap <C-c> :term<CR>

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

" Resize windows
execute "set <M-h>=\eh"
execute "set <M-l>=\el"
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
map <M-h> :vertical resize -2<CR>
map <M-l> :vertical resize +2<CR>
map <M-j> :resize +2<CR>
map <M-k> :resize -2<CR>

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
map <C-p> :GFiles<CR>

" Ycm
map <Leader>gd :YcmCompleter GoToDefinition<CR>
map <Leader>gr :YcmCompleter GoToReferences<CR>
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
