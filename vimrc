" Less clutter in the GUI.
let no_buffers_menu=1

" Toolbars are so yesterday.
set guioptions-=T

" Highlight the current line
set cursorline

" But not the current column, I don't think I've got enough colors for that.
set nocursorcolumn

" Does anybody really like the autocomplete popup help?
set completeopt-=preview

" Don't blink.
set gcr=a:blinkon0

" Customize the wildmenu.
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif
set wildmode=list:full

" We shall not forget.
set history=3000

" Disable mouse.
set mouse=

" Hide mouse pointer while typing
set mousehide
set mousemodel=popup

" Show line numbers.
set relativenumber

" Code folding is neat.
set foldmethod=indent
set foldlevel=99
set foldenable

" Remember vim state
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo

" Remember cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" I don't need no stinking backups
set nobackup
set dir=~/.cache/vim/session

" No one likes you, swapfile.
set noswapfile

" Persistent undo, however, is pretty cool.
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Syntax highlighting? Yes please!
syntax on

" We're always on a fast connection to our vim. Is this needed in neovim?
set ttyfast

" Font and background
if has("gui_running")
  set guifont=Ubuntu\ Mono\ derivative\ Powerline
    set bg=light
else
    set bg=dark
endif

" Highlight textwidth column
set colorcolumn=+0

" Keep some more lines visible
set scrolloff=3

" Better search
set hlsearch
set ignorecase

" Override ignorecase if the search string contains upper case characters.
set smartcase

" Highlight certain whitespaces
set list

" Set our own list characters before sensible mows them over.
set listchars=tab:»\ ,trail:·,extends:»,precedes:«,nbsp:+

" Enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F\ -\ Vim

" Statusbar and Linenumbers
" -------------------------
" Make the command line two lines heigh and change the statusline display to
" something that looks useful.
set cmdheight=2

" With fugitive in place.
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set showmode

" ===========
" Visual Mode
" ===========

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
" <C-r> let's you replace stuff
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" =========================
" Default filetype settings
" =========================

" Indention
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" But don't outdent hashes
inoremap # X#

" Multiples of shiftwidth, always!
set shiftround

" No exceptions, it's > y2k
set encoding=utf-8

" Prefer unix line ends
set fileformats=unix,dos,mac

" Controversial.
set textwidth=80

" ====================
" Plugin configuration
" ====================

" Use jsxhint instead of the pure jshint for XML madness
let g:syntastic_javascript_jshint_exec = "jsxhint"
let g:syntastic_javascript_checkers = ["jshint"]

let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_always_populate_loc_list = 1

" Haskell
nmap <silent> <leader>ht :HdevtoolsType<CR>
nmap <silent> <leader>hi :HdevtoolsInfo<CR>
nmap <silent> <leader>hs :HsimportSymbol<CR>
nmap <silent> <leader>hh :GhcModTypeClear<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>

function! FindCabalSandboxRoot()
    return '/app/sandbox/'
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d')
endfunction

let g:syntastic_hdevtools_options = '-g-ilib -g-isrc -g-i. -g-idist/build/autogen -g-Wall -g-package-conf='.FindCabalSandboxRootPackageConf()

" Auto-checking on writing
autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
function! SetToCabalBuild()
    if glob("*.cabal") != ''
        set makeprg=cabal\ build
    endif
endfunction

autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()
autocmd BufEnter *.hs,*.lhs :setlocal omnifunc=necoghc#omnifunc

" XHTML is dead.
let g:closetag_html_style=1

" Unite
let g:unite_source_history_yank_enable = 1

try
  let g:unite_source_rec_async_command =
     \ 'ag --follow --nocolor --nogroup --hidden -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry

" search a file in the filetree
nnoremap <leader>t :<C-u>Unite -start-insert file_rec/async<cr>

" search in all buffers
nnoremap <leader>m :<C-u>Unite -start-insert buffer<cr>

" search through the yank buffer
nnoremap <leader>y :<C-u>Unite history/yank<CR>

" Use current hsenv's ghc
let g:ghc=system("/usr/bin/which ghc")

set background=dark
let g:solarized_termtrans = 1

" Lightline setup
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" Netrw hist
let g:netrw_home = "/tmp"
let g:netrw_list_hide = '.*\.py[co]$'

" Load plugins
source ~/.vim/plug.vim

" This messes up stuff badly if not set in my terminal emu
" Sensible comes with an foolish default of 100, tho
set ttimeoutlen=-1

" ==================
" Global Keymappings
" ==================

" Hit F3 to toggle paste mode
set pastetoggle=<F3>

" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
noremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" Hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Hide search highlights
nnoremap <leader>n :noh<CR>

" Run Vimux Last Comand
nnoremap <leader>v :VimuxRunLastCommand<CR>

" ===============
" Useful snippets
" ===============

function! HighlightNonBreakingSpace()
  syn match suckingNonBreakingSpace " " containedin=ALL
  hi suckingNonBreakingSpace guibg=#157249
endfunction
autocmd BufEnter * :call HighlightNonBreakingSpace()

" ==========================
" Filetype specific settings
" ==========================

" Python
let python_highlight_all=1
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
\ formatoptions+=croq softtabstop=4 smartindent tw=78
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" Sass
autocmd FileType sass setlocal shiftwidth=4 textwidth=0 softtabstop=4

" Go
autocmd FileType go setlocal noexpandtab

" Yaml
autocmd FileType yaml setlocal shiftwidth=2 textwidth=0 softtabstop=2

" Git commits
autocmd FileType gitcommit setlocal textwidth=72

" ToggleBG
call togglebg#map("<F5>")

" =============
" Personal crap
" =============

" Format JSON
noremap <leader>js %!python -m json.tool<CR>

colorscheme solarized

" via: http://vim.wikia.com/wiki/HTML_entities
function! HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

map <silent> <Leader>he :call HtmlEscape()<CR>
map <silent> <Leader>hu :call HtmlUnEscape()<CR>

" Fix broken syntax highlighting on demand, e.g. when in the middle
" of a huge docstring in python.
map <silent> <Leader>s :syntax sync fromstart<CR>

" Elm keybindings
nnoremap <leader>el :ElmEvalLine<CR>
vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
nnoremap <leader>ep :ElmPrintTypes<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>

" Fake '|' as text object
nnoremap di\| T\|d,
nnoremap da\| F\|d,
nnoremap ci\| T\|c,
nnoremap ca\| F\|c,
nnoremap yi\| T\|y,
nnoremap ya\| F\|y,
nnoremap vi\| T\|v,
nnoremap va\| F\|v,

" Fake '/' as text object
nnoremap di/ T/d,
nnoremap da/ F/d,
nnoremap ci/ T/c,
nnoremap ca/ F/c,
nnoremap yi/ T/y,
nnoremap ya/ F/y,
nnoremap vi/ T/v,
nnoremap va/ F/v,

" Fuck K!
nnoremap K k

" pylint is crazy pants. Let's stick to flake8.
let g:syntastic_python_checkers=['flake8']

" Fix the most common TodoMVC style issues.
function! FixTodoMVC()
  set ts=4
  set sw=4
  set noexpandtab
  silent %s/function(/function (/eg
  silent %s/( /(/eg
  silent %s/ )/)/eg
  silent %s/ ]/]/eg
  silent %s/\[ /\[/eg
  silent %s/){/) {/eg
  silent %s/,\[/, \[/eg
endfunction
