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
let g:ycm_extra_conf_globlist = ['/home/felix/.vim/.ycm_extra_conf.py', '/home/felix/Repositories/HULKs/nao/*']
let g:ycm_confirm_extra_conf = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 1

nnoremap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>


" fzf.vim (search for files) ---------------------------------------------------
Plugin 'junegunn/fzf.vim'

" these are independent of the fzf.vim plugin
set rtp+=~/.fzf

nnoremap <leader>s :FZF<CR>


" ack.vim (search in files) ----------------------------------------------------
Plugin 'mileszs/ack.vim'

" replace ack with the silver searcher (ag)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" do not trim the whitespace
nnoremap <leader>a :Ack 


" vim-clang-format -------------------------------------------------------------
Plugin 'rhysd/vim-clang-format'

" base16-vim (color themes) ----------------------------------------------------
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

let NERDTreeShowHidden=1

map <leader>n :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" nerdcommenter (comment-in/comment-out things) --------------------------------
Plugin 'scrooloose/nerdcommenter'

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'


" vim-gitgutter (show git diff in gutter) --------------------------------------
Plugin 'airblade/vim-gitgutter'

let g:gitgutter_sign_removed = "-"


" vim-fugitive (git wrapper) ---------------------------------------------------
Plugin 'tpope/vim-fugitive'


" vim-rhubarb (:Gbrowse etc.) --------------------------------------------------
Plugin 'tpope/vim-rhubarb'


" vim-better-whitespace --------------------------------------------------------
Plugin 'ntpeters/vim-better-whitespace'

let g:show_spaces_that_precede_tabs=1

map <leader>fw :StripWhitespace<CR>


" tabular (text alignment) -----------------------------------------------------
Plugin 'godlygeek/tabular'


" vim-markdown (requires tabular) ----------------------------------------------
Plugin 'plasticboy/vim-markdown'

let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
" syntax highlighting for tex math
let g:vim_markdown_math = 1
" syntax highlighting for frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

map <leader>ft :TableFormat<CR>


" vim-toml ---------------------------------------------------------------------
Plugin 'cespare/vim-toml'


" vim-json ---------------------------------------------------------------------
Plugin 'elzr/vim-json'


" vimtex -----------------------------------------------------------------------
Plugin 'lervag/vimtex'


" ultisnips (snippet engine) ---------------------------------------------------
Plugin 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsSnippetDirectories = ['/home/felix/.vim/bundle/vim-snippets/UltiSnips']
if getcwd() =~ "nao"
  call add(g:UltiSnipsSnippetDirectories,'/home/felix/Repositories/HULKs/nao/tools/IDEPlugins/NaoSnippets')
endif


" vim-snippets (collecion of snippets) -----------------------------------------
Plugin 'honza/vim-snippets'


" vim-surround (change surroundings) -------------------------------------------
"Plugin 'tpope/vim-surround'


" rainbow_parentheses.vim ------------------------------------------------------
Plugin 'junegunn/rainbow_parentheses.vim'

" activate when starting vim
autocmd VimEnter * RainbowParentheses
map <leader>tr :RainbowParentheses!!<CR>
" blacklist blue, white, dark grey and light grey
let g:rainbow#blacklist = [6, 7, 8, 15]


" vim-cpp-enhanced-highlight ---------------------------------------------------
Plugin 'octol/vim-cpp-enhanced-highlight'


" goyo (distraction free) ------------------------------------------------------
Plugin 'junegunn/goyo.vim'



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
set directory^=$HOME/.vim/tmp// " tmp dir for swp files
let g:tex_flavor = "latex" " reqiured for YouCompleteMe and UltiSnips

" some custom maps --------------------------------------------------------------------
" make Y behave like D
nnoremap Y y$

" make S behave as I expect it to behave in visual mode
vnoremap S xgvI

" jump to next/previous section
nmap <C-n> ]]
nmap <C-p> [[

" move current line to the left/bottom/top/right
nnoremap <C-h> <<
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-l> >>

" new line after current line and leave insert mode
nnoremap <CR> o<Esc>

" new line before current line, leave insert mode and move back to previous line
nnoremap <BS> O<Esc>j

" jump to last non-whitespace character of current line (analogous to ^, which  jumps to the first non-whitespace character)
nnoremap _ g_

nnoremap <leader>v :NERDTreeClose<CR> :vsplit<CR>
nnoremap <leader>m :! make<CR><CR>
nnoremap <leader>p :! pandoc-compose<CR><CR>

" change tabs
map K gt
map J gT

" copy selection
vnoremap <C-c> "+y


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


" run command on current file --------------------------------------------------
function RunWith(command)
    execute "w"
    execute "!clear; " . a:command . " " . expand("%")
endfunction


" compile markdown file --------------------------------------------------------
function CompileMarkdown()
    execute ":w"
    if(filereadable('pandoc-compose.yaml') || filereadable('pandoc-compose.yml'))
        execute "!pandoc-compose"
        execute "!evince $(ls | grep pdf) >/dev/null 2>&1 &"
    else
        execute "!pandoc -o %:t:r.pdf %:t:r.md"
        execute "!evince %:t:r.pdf >/dev/null 2>&1 &"
    endif
endfunc


" compile latex file -----------------------------------------------------------
function CompileLatex()
    execute "w"
    execute "!latexmk -pdf %:t:r.tex"
    execute "!evince %:t:r.pdf >/dev/null 2>&1 &"
endfunc


" clang format -----------------------------------------------------------------
map <leader>fc :ClangFormat<CR>


" convert github pulse (merged PRs) to markdown notes -------------------------
map <leader>.pulse :call ConvertGitHubPulseToMarkdown()<CR>

function! ConvertGitHubPulseToMarkdown()
    normal 0vt#s- $v3bhxj
endfunction


" toggle wrapping --------------------------------------------------------------
map <leader>tw :call ToggleWrapping()<CR>

function! ToggleWrapping()
    if(&wrap == 1)
        set nowrap
    elseif(&wrap == 0)
        set wrap
    endif
endfunc


" toggle folding ---------------------------------------------------------------
map <leader>tf :call ToggleFolding()<CR>

" toggle folding function
function! ToggleFolding()
    if &foldmethod ==# "indent"
        set foldmethod=expr
    else
        set foldmethod=indent
    endif
endfunction

" toggle line numbers ----------------------------------------------------------
nmap <leader>tl :call ToggleLineNumber()<CR>

function ToggleLineNumber()
    if (&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc


" jump between cpp and hpp -----------------------------------------------------
nmap <leader>th :call ToggleSourceHeader()<CR>

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


" goyo enter and leave ---------------------------------------------------------
function! s:goyo_enter()
    " jump to next/previous section and move current line to middle of screen
    nmap <C-n> ]]zt
    nmap <C-p> [[zt
    set scrolloff=0 " restore normal scrolling behavior
endfunction

function! s:goyo_leave()
    " jump to next/previous section
    nmap <C-n> ]]
    nmap <C-p> [[
    set scrolloff=1337 " focus centre of screen (vertically) while scrolling
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" filetype specific things -----------------------------------------------------
autocmd FileType cpp setlocal tabstop=2
autocmd FileType cpp setlocal softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2
autocmd FileType hpp setlocal tabstop=2
autocmd FileType hpp setlocal softtabstop=2
autocmd FileType hpp setlocal shiftwidth=2
autocmd FileType sh setlocal tabstop=2
autocmd FileType sh setlocal softtabstop=2
autocmd FileType sh setlocal shiftwidth=2
autocmd FileType python noremap <leader>r :call RunWith("python3")<CR>
autocmd FileType markdown noremap <leader>r :call CompileMarkdown()<CR>
autocmd FileType tex noremap <leader>r :call CompileLatex()<CR>


" colorscheme ------------------------------------------------------------------
" must be at end of file
colorscheme base16-default-dark
