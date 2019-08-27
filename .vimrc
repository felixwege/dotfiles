set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader=" " " space bar

" Automatically install vim-plug and plugins
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins ----------------------------------------------
call plug#begin('~/.vim/autoload')


" YouCompleteMe (auto-completion) ----------------------------------------------
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_extra_conf_globlist = ['/home/felix/.vim/.ycm_extra_conf.py', '/home/felix/Repositories/HULKs/nao/*']
let g:ycm_confirm_extra_conf = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 1

" do not show preview window
set completeopt-=preview

nnoremap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>


" fzf and fzf.vim (search for files) -------------------------------------------
"
" Install fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Actual plugin
Plug 'junegunn/fzf.vim'

" these are independent of the fzf.vim plugin
set rtp+=~/.fzf

nnoremap <leader>s :Files<CR>


" ctrlsf.vim (Sublime-like search window using ripgrep) ------------------------
Plug 'dyng/ctrlsf.vim'

" search for pattern (do not trim the whitespace, press Enter to search for word under cursor)
nnoremap <leader>a :only<CR> <bar> :CtrlSF 
" search for visual selection
vmap <leader>a <Plug>CtrlSFVwordExec

" always use ripgrep if it exists
if (executable('rg'))
    let g:ctrlsf_ackprg = '/usr/bin/rg'
endif

" switch focus to ctrlsf window
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

" don't close ctrlsf window
let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}


" jeetsukumaran/vim-buffergator (list and switch buffers) ----------------------
Plug 'jeetsukumaran/vim-buffergator'


" vim-clang-format -------------------------------------------------------------
Plug 'rhysd/vim-clang-format'


" vim-yapf ---------------------------------------------------------------------
Plug 'mindriot101/vim-yapf', { 'for': 'python' }


" base16-vim (color themes) ----------------------------------------------------
Plug 'chriskempson/base16-vim'

let base16colorspace=256  " Access colors present in 256 colorspace


" vim-airline (status line) ----------------------------------------------------
Plug 'vim-airline/vim-airline'

let g:airline_theme='base16'

let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c='%f%m%r'
let g:airline_section_z='%l/%L %c'

" display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" only show tail of relative file path (the actual file name)
let g:airline#extensions#tabline#formatter = 'unique_tail'


" vim-airline-themes (status line themes) --------------------------------------
Plug 'vim-airline/vim-airline-themes'


" nerdtree (tree explorer) -----------------------------------------------------
Plug 'scrooloose/nerdtree'

let NERDTreeShowHidden=1

map <leader>nt :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" nerdcommenter (comment-in/comment-out things) --------------------------------
Plug 'scrooloose/nerdcommenter'

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDSpaceDelims = 0
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 0


" vim-gitgutter (show git diff in gutter) --------------------------------------
Plug 'airblade/vim-gitgutter'

let g:gitgutter_sign_removed = "-"
let g:gitgutter_map_keys = 0


" vim-fugitive (git wrapper) ---------------------------------------------------
Plug 'tpope/vim-fugitive'


" vim-rhubarb (:Gbrowse etc.) --------------------------------------------------
Plug 'tpope/vim-rhubarb'


" vim-better-whitespace --------------------------------------------------------
Plug 'ntpeters/vim-better-whitespace'

let g:show_spaces_that_precede_tabs=1

map <leader>fw :StripWhitespace<CR>


" tabular (text alignment) -----------------------------------------------------
Plug 'godlygeek/tabular'


" vim-markdown (requires tabular) ----------------------------------------------
Plug 'plasticboy/vim-markdown'

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
Plug 'cespare/vim-toml'


" vim-json ---------------------------------------------------------------------
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0


" vimtex -----------------------------------------------------------------------
Plug 'lervag/vimtex', { 'for': 'tex' }


" ultisnips (snippet engine) ---------------------------------------------------
Plug 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
let g:UltiSnipsSnippetDirectories = ['/home/felix/.vim/bundle/vim-snippets/UltiSnips']
if getcwd() =~ "nao"
  call add(g:UltiSnipsSnippetDirectories,'/home/felix/Repositories/HULKs/nao/tools/IDEPlugins/NaoSnippets')
endif


" vim-snippets (collecion of snippets) -----------------------------------------
Plug 'honza/vim-snippets'

" vim-doge (insert documentation skeleton) -------------------------------------
Plug 'kkoomen/vim-doge'

let g:doge_mapping_comment_jump_forward = '<C-l>'
let g:doge_mapping_comment_jump_backward = '<C-h>'
let g:doge_doc_standard_python = 'google'


" vim-surround (change surroundings) -------------------------------------------
Plug 'tpope/vim-surround'


" switch.vim (toggle boolean) --------------------------------------------------
Plug 'AndrewRadev/switch.vim'

" disable default mapping
let g:switch_mapping = ""

map <leader>~ :call switch#Switch()<CR>


" machakann/vim-swap (swap delimited items) ------------------------------------
Plug 'machakann/vim-swap'


" RRethy/vim-illuminate (highlight word under cursor) --------------------------
Plug 'RRethy/vim-illuminate'

let g:Illuminate_delay = 0


" rainbow_parentheses.vim ------------------------------------------------------
Plug 'junegunn/rainbow_parentheses.vim'

" activate when starting vim
autocmd VimEnter * RainbowParentheses
map <leader>tr :RainbowParentheses!!<CR>
let g:rainbow#blacklist = [15, 7, 1, 242, 12, 8, 6, 2, 3]


" vim-cpp-enhanced-highlight ---------------------------------------------------
Plug 'octol/vim-cpp-enhanced-highlight'


" felixwege/semshi (python semantic highlighting) ------------------------------
if has('nvim')
    Plug 'felixwege/semshi', { 'for': 'python', 'do': ':UpdateRemotePlugins' }
endif


" mboughaba/i3config.vim (i3 config syntax highlighting) -----------------------
Plug 'mboughaba/i3config.vim', { 'for': 'i3config' }


" goyo (distraction free) ------------------------------------------------------
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

let g:goyo_width = 100
let g:goyo_height = 50


" limelight (Hyperfocus-writing) -----------------------------------------------
Plug 'junegunn/limelight.vim'


" BufOnly (delete all buffers extept the curent one with :BufOnly) -------------
Plug 'vim-scripts/BufOnly.vim'


" Initialize plugin system -----------------------------------------------------
call plug#end()


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

" jump to next/previous section
nmap <C-n> ]]
nmap <C-p> [[
vmap <C-n> ]]
vmap <C-p> [[

" single guillements move current line to the left/right
noremap < <<
noremap > >>

" new line after current line and leave insert mode
nnoremap <CR> o<Esc>

" backspace moves to the left and deletes
nnoremap <BS> hx

" jump to last non-whitespace character of current line (analogous to ^, which  jumps to the first non-whitespace character)
nnoremap _ g_

nnoremap <leader>v :NERDTreeClose<CR> :vsplit<CR><C-w><C-l>
nnoremap <leader>h :NERDTreeClose<CR> :split<CR><C-w><C-j>
nnoremap <leader>m :! make<CR><CR>

" substitute word under cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left><Paste>

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


nnoremap <leader>gb :Gblame<CR>

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


" set/remove/toggle ipdb breakpoints -------------------------------------------
function! IPDBSetBreakpoint()
    call append(line('.')-1, repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
    execute 'normal k'
endfunction

function! IPDBRemoveBreakpoint()
    execute 'silent! g/^\s*import\sipdb\;\?\n*\s*ipdb.set_trace()/d'
endfunction

function! IPDBToggleBreakpoint()
    if getline('.')=~#'^\s*import\sipdb' | call IPDBRemoveBreakpoint() | else | call IPDBSetBreakpoint() | endif
    write
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

" enable i3 config syntax highlighting
augroup i3config_ft_detection
    autocmd!
    autocmd BufNewFile,BufRead */i3/config set filetype=i3config
augroup end


augroup IPDBBreakpoints
    autocmd!
    autocmd FileType python nnoremap <leader>ps :call IPDBSetBreakpoint()<CR>
    autocmd FileType python nnoremap <leader>pr :call IPDBRemoveBreakpoint()<CR>
    autocmd FileType python nnoremap <leader>pt :call IPDBToggleBreakpoint()<CR>
augroup end


" colorscheme ------------------------------------------------------------------
" must be at end of file
colorscheme base16-default-dark

" highlight spelling errors (this must be after the colorscheme)
highlight SpellBad        ctermfg=Red   ctermbg=White cterm=underline guifg=Red   guibg=White gui=underline
highlight SpellCap        ctermfg=Red   ctermbg=White cterm=underline guifg=Red   guibg=White gui=underline
highlight SpellLocal      ctermfg=Red   ctermbg=White cterm=underline guifg=Red   guibg=White gui=underline
highlight SpellRare       ctermfg=Red   ctermbg=White cterm=underline guifg=Red   guibg=White gui=underline
highlight illuminatedWord ctermfg=Black ctermbg=Blue                  guifg=Black guibg=Blue
