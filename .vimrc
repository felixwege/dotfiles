set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader=" " " space bar


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

nnoremap <leader>s :Files<CR>
nnoremap <leader>b :Buffers<CR>


" vim-ripgrep ------------------------------------------------------------------
Plugin 'jremmen/vim-ripgrep'

" do not trim the whitespace
nnoremap <leader>r :Rg 

" vim-clang-format -------------------------------------------------------------
Plugin 'rhysd/vim-clang-format'


" vim-yapf ---------------------------------------------------------------------
Plugin 'mindriot101/vim-yapf'


" base16-vim (color themes) ----------------------------------------------------
Plugin 'chriskempson/base16-vim'

let base16colorspace=256  " Access colors present in 256 colorspace


" vim-airline (status line) ----------------------------------------------------
Plugin 'vim-airline/vim-airline'

let g:airline_theme='base16'

let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c='%f%m%r'
let g:airline_section_z='%l/%L %c'

" display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" only show tail of relative file path (the actual file name)
let g:airline#extensions#tabline#formatter = 'unique_tail'


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
let g:vim_json_syntax_conceal = 0


" vimtex -----------------------------------------------------------------------
Plugin 'lervag/vimtex'


" ultisnips (snippet engine) ---------------------------------------------------
Plugin 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
let g:UltiSnipsSnippetDirectories = ['/home/felix/.vim/bundle/vim-snippets/UltiSnips']
if getcwd() =~ "nao"
  call add(g:UltiSnipsSnippetDirectories,'/home/felix/Repositories/HULKs/nao/tools/IDEPlugins/NaoSnippets')
endif


" vim-snippets (collecion of snippets) -----------------------------------------
Plugin 'honza/vim-snippets'


" vim-surround (change surroundings) -------------------------------------------
"Plugin 'tpope/vim-surround'


" switch.vim (toggle boolean) --------------------------------------------------
Plugin 'AndrewRadev/switch.vim'

" disable default mapping
let g:switch_mapping = ""

map <leader>tb :call switch#Switch()<CR>


" machakann/vim-swap (swap delimited items) ------------------------------------

Plugin 'machakann/vim-swap'


" rainbow_parentheses.vim ------------------------------------------------------
Plugin 'junegunn/rainbow_parentheses.vim'

" activate when starting vim
autocmd VimEnter * RainbowParentheses
map <leader>tr :RainbowParentheses!!<CR>
let g:rainbow#blacklist = [15, 7, 1, 242, 12, 8, 6, 2, 3]


" vim-cpp-enhanced-highlight ---------------------------------------------------
Plugin 'octol/vim-cpp-enhanced-highlight'


" felixwege/semshi (python semantic highlighting) ------------------------------
if has('nvim')
    Plugin 'felixwege/semshi'
endif


" goyo (distraction free) ------------------------------------------------------
Plugin 'junegunn/goyo.vim'

let g:goyo_width = 100
let g:goyo_height = 50


" limelight (Hyperfocus-writing) -----------------------------------------------
Plugin 'junegunn/limelight.vim'


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
set guicursor=
set expandtab " spaces > tabs
syntax enable
set number relativenumber "absolute number for current line and relative numbers for all other lines
set showcmd " show key strokes
set path+=**
set scrolloff=1337 " focus centre of screen (vertically) while scrolling
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=UTF-8
set nowrap " do not wrap long lines
set ignorecase " case insensitive search
set hlsearch " highlight search results
set incsearch " highlight things while searching
set smartcase " respect explicitly typed uppercase letters
set wildmenu
set spelllang=en_us
set noautoread
set hidden " hide buffers instead of closing them
set backspace=indent,eol,start
set directory^=$HOME/.vim/tmp// " tmp dir for swp files
let g:tex_flavor = "latex" " reqiured for YouCompleteMe and UltiSnips

" some custom maps --------------------------------------------------------------------
" make Y behave like C and D
nnoremap Y y$

" make S behave like I in visual block mode
vnoremap S xgvI

" jump to next/previous section
nmap <C-n> ]]
nmap <C-p> [[

" single guillements move current line to the left/right
noremap < <<
noremap > >>

" new line after current line and leave insert mode
nnoremap <CR> o<Esc>

" backspace moves to the left and deletes
nnoremap <BS> hx

" jump to last non-whitespace character of current line (analogous to ^, which  jumps to the first non-whitespace character)
nnoremap _ g_

nnoremap <leader>v :NERDTreeClose<CR> :vsplit<CR>
nnoremap <leader>m :! make<CR><CR>

" change buffers
map J :bprevious<CR>
map K :bnext<CR>

" close buffer
map Q :bdelete<CR>

" copy selection
vnoremap <C-c> "+y

" clear search highlight
noremap <silent> <leader>/ :nohlsearch<CR>
noremap <silent> <leader>* :nohlsearch<CR>
noremap <silent> <leader># :nohlsearch<CR>

vnoremap <leader>s :sort<CR>

" align current paragraph
noremap <leader>fa =ip

" scroll quarter of the screen up or down (yes, I know that the order is
" reversed compared to the default vim bindings)
nnoremap <C-y> :call ScrollQuarterScreen('down')<CR>
nnoremap <C-e> :call ScrollQuarterScreen('up')<CR>


" scroll a quarter of the screen up or down ------------------------------------
function ScrollQuarterScreen(direction)
    if a:direction == 'down'
        execute 'normal! ' . winheight(0)/4 . 'j'
    else
        execute 'normal! ' . winheight(0)/4 . 'k'
    endif
endfunction


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
        "execute "!evince $(ls | grep pdf) >/dev/null 2>&1 &"
    else
        execute "!pandoc -o %:t:r.pdf %:t:r.md"
        "execute "!evince %:t:r.pdf >/dev/null 2>&1 &"
    endif
endfunc


" compile latex file -----------------------------------------------------------
function CompileLatex()
    execute "w"
    execute "!latexmk -pdf %:t:r.tex"
    "execute "!evince %:t:r.pdf >/dev/null 2>&1 &"
endfunc


" compile graph (dot languate) file --------------------------------------------
function CompileGraph()
    execute "w"
    execute "!dot -Tpdf %:t:r.dot > %:t:r.pdf"
    "execute "!evince %:t:r.pdf >/dev/null 2>&1 &"
endfunc


" clang format -----------------------------------------------------------------
map <leader>fc :ClangFormat<CR>


" yapf ------------------------------------------------------------------------
nnoremap <leader>fp :call Yapf()<cr>


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


" toggle spell checking --------------------------------------------------------
nmap <leader>ts :call ToggleSpellChecking()<CR>

function ToggleSpellChecking()
    if(&spell == 1)
        set nospell
    elseif(&spell == 0)
        set spell
    endif
endfunc

" goyo enter and leave ---------------------------------------------------------
function! s:goyo_enter()
    Limelight
    " jump to next/previous section and move current line to middle of screen
    nmap <C-n> ]]zt
    nmap <C-p> [[zt
endfunction

function! s:goyo_leave()
    Limelight!
    " jump to next/previous section
    nmap <C-n> ]]
    nmap <C-p> [[
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
autocmd FileType xml setlocal tabstop=4
autocmd FileType xml setlocal softtabstop=0
autocmd FileType xml setlocal shiftwidth=4
autocmd FileType xml setlocal noexpandtab
autocmd FileType python noremap <leader>e :call RunWith("python3")<CR>
autocmd FileType markdown noremap <leader>e :call CompileMarkdown()<CR>
autocmd FileType tex noremap <leader>e :call CompileLatex()<CR>
autocmd FileType dot noremap <leader>e :call CompileGraph()<CR>
autocmd FileType gz noremap <leader>e :call CompileGraph()<CR>


" colorscheme ------------------------------------------------------------------
" must be at end of file
colorscheme base16-default-dark

" highlight spelling errors (this must be after the colorscheme)
highlight SpellBad		ctermfg=Red		ctermbg=White	cterm=underline		guifg=Red	guibg=White		gui=underline
highlight SpellCap		ctermfg=Red		ctermbg=White	cterm=underline		guifg=Red	guibg=White		gui=underline
highlight SpellLocal	ctermfg=Red		ctermbg=White	cterm=underline		guifg=Red	guibg=White		gui=underline
highlight SpellRare		ctermfg=Red		ctermbg=White	cterm=underline		guifg=Red	guibg=White		gui=underline
