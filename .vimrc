set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" search
Plugin 'kien/ctrlp.vim'

" status line
Plugin 'vim-airline/vim-airline'

" status line themes
Plugin 'vim-airline/vim-airline-themes'

" color palette
Plugin 'chriskempson/base16-vim'

" tree explorer
Plugin 'scrooloose/nerdtree'

" show git diff in gutter
Plugin 'airblade/vim-gitgutter'

" git wrapper
Plugin 'tpope/vim-fugitive'

" :Gbrowse etc
Plugin 'tpope/vim-rhubarb'

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

"---------- some small things ----------

" set leader key to ,
let mapleader=","

" highlight cursor row
set cursorline

" hightlight cursor column
set cursorcolumn

" spaces > tabs
set expandtab

syntax enable

" relative line numbers
set number relativenumber

" show keys pressed
set showcmd

set path+=**

" focus centre of screen (vertically) while scrolling
set scrolloff=1337

"---------- tabstop, softtabstop, shiftwidth ----------
" default values
set tabstop=4
set softtabstop=4
set shiftwidth=4

" different values for c++
autocmd FileType cpp setlocal tabstop=2
autocmd FileType cpp setlocal softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2
autocmd FileType hpp setlocal tabstop=2
autocmd FileType hpp setlocal softtabstop=2
autocmd FileType hpp setlocal shiftwidth=2

"---------- search ----------
" case insensitive search
set ignorecase

" highlight search results
set hlsearch

" highlight things while searching
set incsearch

" clear search highlight
noremap <silent> <CR> :nohlsearch<CR>

"---------- airline ----------
let g:airline_theme='base16'

let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c='%f%m%r'
let g:airline_section_z='%l/%L %c'

"---------- ctrlp ----------
" remap ctrlp key
let g:ctrlp_map='<leader>p'

"---------- nerd tree ----------
" toggle nerdtree
map <leader>n :NERDTreeToggle<CR>

" automatically close nerdtree if it is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"---------- git gutter ----------
" change gitgutter removed sign from _ to -
let g:gitgutter_sign_removed = "-"

"---------- clang format ----------
map <leader>c :ClangFormat<CR>

"---------- toggle folding ----------
" toggle folding key
map <leader>f :call ToggleFolding()<CR>

" toggle folding function
function! ToggleFolding()
    if &foldmethod ==# "indent"
        set foldmethod=expr
    else
        set foldmethod=indent
    endif
endfunction

"---------- jump between cpp and hpp ----------
" toggle source header key
nmap <leader>h :call ToggleSourceHeader()<CR>

" toggle source header function
function ToggleSourceHeader()
    let extension = expand('%:e')
    if(extension == "hpp")
        let file = expand('%:r') . '.cpp'
        if filereadable(file)
            execute ":e %:r.cpp"
        endif
    elseif(extension == "h")
        let file = expand('%:r') . '.cpp'
        if filereadable(file)
            execute ":e %:r.cpp"
        endif
    elseif(extension == "cpp")
        let file = expand('%:r') . '.hpp'
        if filereadable(file)
            execute ":e %:r.hpp"
        endif
        let file = expand('%:r') . '.h'
        if filereadable(file)
            execute ":e %:r.h"
        endif
     endif
endfunc

"---------- you complete me ----------
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_extra_conf_globlist = ['~/Repositories/HULKs/nao/*']

nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"---------- echo doc ----------
set noshowmode
let g:echodoc#enable_at_startup=1

"---------- base 16 ----------
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default-dark
