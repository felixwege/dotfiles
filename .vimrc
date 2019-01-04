set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader=","


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" YouCompleteMe (auto-completion) ----------------------------------------------
Plugin 'Valloric/YouCompleteMe'

let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_extra_conf_globlist = ['~/Repositories/HULKs/nao/*']

nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" fzf.vim (search) -------------------------------------------------------------
Plugin 'junegunn/fzf.vim'

" these are independent of the fzf.vim plugin
set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>

nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pc :BCommits<CR>


" base16-vim (color themes)
Plugin 'chriskempson/base16-vim'

let base16colorspace=256  " Access colors present in 256 colorspace


" vim-airline (status line) ----------------------------------------------------
Plugin 'vim-airline/vim-airline'

let g:airline_theme='base16'

let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c='%f%m%r'
let g:airline_section_z='%l/%L %c'


" vim-airline-themes (status line themes) --------------------------------------
Plugin 'vim-airline/vim-airline-themes'

" nerdtree (tree explorer) -----------------------------------------------------
Plugin 'scrooloose/nerdtree'

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" vim-gitgutter (show git diff in gutter) --------------------------------------
Plugin 'airblade/vim-gitgutter'

let g:gitgutter_sign_removed = "-"


" vim-fugitive (git wrapper) ---------------------------------------------------
Plugin 'tpope/vim-fugitive'


" vim-rhubarb (:Gbrowse etc.) --------------------------------------------------
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


" general settings -------------------------------------------------------------
set cursorline
set cursorcolumn
set expandtab " spaces > tabs
syntax enable
set number relativenumber "absolute number for current line and relative numbers for all other lines
set showcmd " show key strokes
set path+=**
set scrolloff=1337 " focus centre of screen (vertically) while scrolling
set encoding=UTF-8
set nowrap " do not wrap long lines
set ignorecase " case insensitive search


" search -----------------------------------------------------------------------
set hlsearch " highlight search results
set incsearch " highlight things while searching

" clear search highlight
noremap <silent> <leader>/ :nohlsearch<CR>
noremap <silent> <leader>* :nohlsearch<CR>
noremap <silent> <leader># :nohlsearch<CR>


" tabstop, softtabstop, shiftwidth ---------------------------------------------
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


" clang format -----------------------------------------------------------------
map <leader>c :ClangFormat<CR>


" toggle wrapping --------------------------------------------------------------
map <leader>w :call ToggleWrapping()<CR>

function! ToggleWrapping()
  if(&wrap == 1)
    set nowrap
  elseif(&wrap == 0)
    set wrap
  endif
endfunc


" toggle folding ---------------------------------------------------------------
map <leader>f :call ToggleFolding()<CR>

" toggle folding function
function! ToggleFolding()
    if &foldmethod ==# "indent"
        set foldmethod=expr
    else
        set foldmethod=indent
    endif
endfunction


" jump between cpp and hpp -----------------------------------------------------
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


" colorscheme ------------------------------------------------------------------
" must be at end of file
colorscheme base16-default-dark
