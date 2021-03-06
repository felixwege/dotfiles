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


" coc.vim ----------------------------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = ['coc-sh', 'coc-tsserver', 'coc-eslint', 'coc-css', 'coc-html', 'coc-json', 'coc-yaml', 'coc-prettier', 'coc-python', 'coc-snippets', 'coc-flutter']

" Apply codeAction to the current line
nmap <leader>a  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line
nmap <leader>cq  <Plug>(coc-fix-current)

" Symbol renaming
nmap <leader>cr <Plug>(coc-rename)


" Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gp <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Jump to prev/next diagnostic
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)


" Show documentation in preview window.
nnoremap <silent> <leader>i :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" set up Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd FileType javascript,typescript nmap <leader>f :Prettier<CR>
autocmd FileType javascript,typescript vmap <leader>f <Plug>(coc-format-selected)<CR>

" navigate completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" confirm conpletion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" coc-snippet placeholder navigation
let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'

" list or edit snippets for current file tpe
nnoremap <leader>sl :CocList snippets<CR>
nnoremap <leader>se :CocCommand snippets.editSnippets<CR>


" fzf and fzf.vim (search for files) -------------------------------------------
"
" Install fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


" Actual plugin
Plug 'junegunn/fzf.vim'

" these are independent of the fzf.vim plugin
set rtp+=~/.fzf

nnoremap <leader>e :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>w :Rg <C-R><C-W><CR>
vnoremap <leader>w :call SearchVisualSelection()<CR>
" Not fzf but related to search
autocmd FileType vim nnoremap <leader>h :help <C-R><C-W><CR>

function! SearchVisualSelection()
    call RgFn(GetVisualSelection())
endfunction

" Generic search function
function! RgFn(query)
    let command = 'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(a:query)
    let spec = {'options': ['--phony', '--query', a:query]}
    call fzf#vim#grep(command, 1, fzf#vim#with_preview(spec), 0)
endfunction

" See https://stackoverflow.com/a/6271254
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction


" christoomey/vim-tmux-navigator -----------------------------------------------
Plug 'christoomey/vim-tmux-navigator'


" vim-clang-format -------------------------------------------------------------
Plug 'rhysd/vim-clang-format'

autocmd FileType cpp,hpp,c,h map <leader>f :ClangFormat<CR>



" vim-yapf ---------------------------------------------------------------------
Plug 'mindriot101/vim-yapf', { 'for': 'python' }

autocmd FileType python nnoremap <leader>f :call Yapf()<cr>


" base16-vim (color themes) ----------------------------------------------------
Plug 'chriskempson/base16-vim'

let base16colorspace=256  " Access colors present in 256 colorspace


" vim-airline (status line) ----------------------------------------------------
Plug 'vim-airline/vim-airline'

let g:airline_theme='base16'

let g:airline_section_b='%{fugitive#statusline()}'
let g:airline_section_c='%f%m%r%{ConflictedStatusLineInfo()}'
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

nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" vertical split (same command and behavior as tmux)
nnoremap <leader>% :NERDTreeClose<CR> :vsplit<CR><C-w><C-l>

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

nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>


" vim-rhubarb (:Gbrowse etc.) --------------------------------------------------
Plug 'tpope/vim-rhubarb'

nnoremap <leader>gx :Gbrowse<CR>
vnoremap <leader>gx :Gbrowse<CR>


" christoomey/vim-conflicted ---------------------------------------------------
Plug 'christoomey/vim-conflicted'

nnoremap <leader>gmerge :Conflicted<CR>

function ConflictedStatusLineInfo()
    let info = ConflictedVersion()
    if empty(info)
        return ''
    endif

    return ' | ' . info
endfunction


" vim-better-whitespace --------------------------------------------------------
Plug 'ntpeters/vim-better-whitespace'

let g:show_spaces_that_precede_tabs=1


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


" vim-toml ---------------------------------------------------------------------
Plug 'cespare/vim-toml'


" vim-json ---------------------------------------------------------------------
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0


" vimtex -----------------------------------------------------------------------
Plug 'lervag/vimtex', { 'for': 'tex' }


" vim-snippets (collecion of snippets) -----------------------------------------
Plug 'honza/vim-snippets'


" vim-doge (insert documentation skeleton) -------------------------------------
Plug 'kkoomen/vim-doge'

let g:doge_doc_standard_python = 'google'


" vim-surround (change surroundings) -------------------------------------------
Plug 'tpope/vim-surround'


" vim-repeat (repeat plugin maps with '.')
Plug 'tpope/vim-repeat'


" switch.vim (toggle boolean) --------------------------------------------------
Plug 'AndrewRadev/switch.vim'

" disable default mapping
let g:switch_mapping = ""

map <leader>~ :call switch#Switch()<CR>


Plug 'fmoralesc/vim-pad'

let g:pad#dir = '~/Documents/notes'
let g:pad#window_height = 32
let g:pad#open_in_split = 0
let g:pad#maps#list = '<leader>nl'
let g:pad#maps#new = '<leader>nn'
let g:pad#maps#search = '<leader>ns'
let g:pad#maps#incsearch = ''
let g:pad#maps#newsilent = ''


" machakann/vim-swap (swap delimited items) ------------------------------------
Plug 'machakann/vim-swap'


" tommcdo/vim-exchange (exchange text selections) ------------------------------
Plug 'tommcdo/vim-exchange'


" RRethy/vim-illuminate (highlight word under cursor) --------------------------
Plug 'RRethy/vim-illuminate'

let g:Illuminate_delay = 100


" sheerun/vim-polyglot ---------------------------------------------------------
Plug 'sheerun/vim-polyglot'

autocmd FileType dart map<leader>f :DartFmt<CR>


" thosakwe/vim-flutter ---------------------------------------------------------
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }


" fatih/vim-go -----------------------------------------------------------------

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }

autocmd FileType go map <leader>f :GoFmt<CR>


" goyo (distraction free) ------------------------------------------------------
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

let g:goyo_width = 100
let g:goyo_height = 50


" limelight (Hyperfocus-writing) -----------------------------------------------
Plug 'junegunn/limelight.vim'


" BufOnly (delete all buffers extept the curent one with :BufOnly) -------------
Plug 'vim-scripts/BufOnly.vim'


" suda.vim (sudo.vim, except it works for neovim) ------------------------------
Plug 'lambdalisue/suda.vim'

command SudoWrite w suda://%


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
call mkdir($HOME . "/.vim/swap", "p", 0700)
set directory^=$HOME/.vim/swap// " dir for swap files
let g:tex_flavor = "latex" " reqiured for YouCompleteMe and UltiSnips

" some custom maps --------------------------------------------------------------------
" make Y behave like C and D
nnoremap Y y$

" make A behave similar to I in visual mode (append to lines)
vnoremap A :'<,'>normal A

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

" substitute word under cursor
nnoremap <leader>u :%s/\<<C-r><C-w>\>//g<Left><Left><Paste>

" change buffers
map J :bprevious<CR>
map K :bnext<CR>

" close buffer (from https://stackoverflow.com/questions/4298910/vim-close-buffer-but-not-split-window/19619038#19619038)
nmap Q :b#<bar>bd#<CR>

" copy selection
vnoremap <C-c> "+y

" clear search highlight
noremap <silent> <leader>/ :nohlsearch<CR>
noremap <silent> <leader>* :nohlsearch<CR>
noremap <silent> <leader># :nohlsearch<CR>


nnoremap <leader>gb :Gblame<CR>

vnoremap <leader>s :sort<CR>

" scroll quarter of the screen up or down (yes, I know that the order is
" reversed compared to the default vim bindings)
nnoremap <C-y> :call ScrollQuarterScreen('down')<CR>
nnoremap <C-e> :call ScrollQuarterScreen('up')<CR>

" append semicolon to line
nnoremap <leader>; A;<ESC>


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


" toggle lazygit ---------------------------------------------------------------
if has('nvim')
    nnoremap <leader>gl :call LazyGit()<CR>

    function! LazyGit()
        if bufexists('lazygit') == 0
            let width = float2nr(&columns)
            let height = float2nr(&lines)
            let top = ((&lines - height) / 2) - 1
            let left = (&columns - width) / 2
            let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
            set winhighlight=Normal:Floating
            call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)

            function! OnLazyGitExit(...)
                bdelete!
            endfunction
            call termopen('lazygit', {'on_exit': function('OnLazyGitExit')})
            startinsert
        endif
    endfunction
endif


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
highlight illuminatedWord ctermfg=White ctermbg=Blue                  guifg=White guibg=Blue
