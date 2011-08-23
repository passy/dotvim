" Modern vim, plx.
set nocompatible

" Allow backspace whenever I want it.
set backspace=indent,eol,start

" Less clutter in the GUI.
let no_buffers_menu=1
" Toolbars are so yesterday.
set guioptions-=T

" Highlight the current line
set cursorline

" Does anybody really like the autocomplete popup help?
set completeopt-=preview

" Don't blink.
set gcr=a:blinkon0

" Customize the wildmenu.
set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif
set wildmode=list:full

" We shall not forget.
set history=3000

" Allow 256 colors inside Gnome Terminal.
set t_Co=256

" Enable mouse everywhere.
set mouse=a

" Hide mouse pointer while typing
set mousehide
set mousemodel=popup

" Show the ruler. All. The. Time.
set ruler

" Show line numbers.
set number
set relativenumber

" Code folding is neat.
set foldmethod=indent
set foldlevel=99
set foldenable

" Remember vim state
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo

" Remember cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Backup files live in ~/.vim/session
set backupdir=~/.vim/session
set dir=~/.vim/session

" No one likes you, swapfile.
set noswapfile

" Persistent undo, however, is pretty cool.
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Syntax highlighting? Yes please!
syntax on

" We're always on a fast connection to our vim.
set ttyfast

" Font and background
if has("gui_running")
    set guifont=Consolas\ 11
    set bg=light
else
    set bg=dark
endif

" Highlight textwidth column
set colorcolumn=+0

" Keep some more lines visible
set scrolloff=5

" Better search
set hlsearch
set incsearch
set ignorecase
" Override ignorecase if the search string contains upper case characters.
set smartcase

" Highlight certain whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F\ -\ Vim

" Enable filetype extensions
filetype on
filetype plugin on

" Statusbar and Linenumbers
" -------------------------
" Make the command line two lines heigh and change the statusline display to
" something that looks useful.
set cmdheight=2
set laststatus=2
" With fugitive in place.
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set showcmd
set showmode

" ===========
" Visual Mode
" ===========

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

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
set autoindent

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

" ==================
" Global Keymappings
" ==================

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
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" Sass
autocmd FileType sass setlocal shiftwidth=2 textwidth=0 softtabstop=4

" CoffeeScript
autocmd BufWritePost *.coffee silent CoffeeMake! | cwindow | redraw!

" HTML and templates
fun! s:SelectHTML()
let n = 1
while n < 50 && n < line("$")
  " check for jinja
  if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
    set ft=jinja.html
    return
  endif
  " check for mako
    if getline(n) =~ '<%\(def\|inherit\)'
      set ft=mako
      return
    endif
    " check for genshi
    if getline(n) =~ 'xmlns:py\|py:\(match\|for\|if\|def\|strip\|xmlns\)'
      set ft=genshi
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun

autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()


" ====================
" Plugin configuration
" ====================

" Pathogen initialization

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Command-T

noremap <leader>T <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

" Closetag

autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" SuperTab

let g:SuperTabDefaultCompletionType = "context"

" Solarized (colorscheme)

let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" =============
" Personal crap
" =============

" Append my own bin/ to the vim internal $PATH
let $PATH=$PATH . ":~/Applications/bin"
