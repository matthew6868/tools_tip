set nocompatible              " be iMproved, required
filetype off                  " required

" section
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1ed

" Show line numbers
set number
" Show statusline
set laststatus=2

" set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard

set showcmd

" Case-insensitive search
set ignorecase
set incsearch                                                " search as you type

set ruler                                                    " show where you are
" Highlight search results
set hlsearch

set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

" default Indentation
set autoindent      " Indent at the same level of the previous line
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
" set textwidth=79
" " set smarttab
set expandtab       " expand tab to space

" return to last edit position when opening files (You want this!)
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
" colorscheme molokai
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120" Folding

set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=20

" Enable OS mouse clicking and scrolling
"
" Note for Mac OS X: Requires SIMBL and MouseTerm
"
" http://www.culater.net/software/SIMBL/SIMBL.php
" https://bitheap.org/mouseterm/
if has("mouse")
   set mouse=a
endif

syntax on


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Vundle List Here"
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai' " molokai theme
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized' " solarized theme
Plugin 'majutsushi/tagbar'
Plugin 'valloric/youcompleteme'
Plugin 'kien/ctrlp.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" vim theme
syntax enable
" set background=dark
" colorscheme solarized

colorscheme molokai
" let g:molokai_original=1

" NERDTree"
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
" let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\~$', '\.py[cd]$', '\.swp$', '\.wso$', '^\.git$', '^\.hg$', '^\.svn$', '^\.bzr$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F5> :NERDTreeToggle<cr>

" Tagbar"
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<CR>

" parse markdown"
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }
