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

" Allow 16 colors inside Gnome Terminal.
set t_Co=16

" Enable mouse everywhere.
set mouse=a

" Hide mouse pointer while typing
set mousehide
set mousemodel=popup

" Show the ruler. All. The. Time.
set ruler

" Show line numbers.
" set number
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

" We're always on a fast connection to our vim.
set ttyfast

" Font and background
if has("gui_running")
    set guifont=Ubuntu\ Mono\ 12
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
set incsearch
set ignorecase
" Override ignorecase if the search string contains upper case characters.
set smartcase

" Highlight certain whitespaces
set list
set listchars=tab:>.,trail:…,extends:#,nbsp:.

" Enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F\ -\ Vim

" Enable filetype extensions
filetype plugin indent on

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

" Hide search highlights
nnoremap <leader>n :noh<CR>

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

" CoffeeScript
" autocmd BufWritePost *.coffee silent CoffeeMake! | cwindow | redraw!
let coffee_lint_options = '/home/pascal/Dropbox/dotfiles/coffeelint.json'
let coffee_linter = '/home/pascal/.npm/bin/coffeelint'
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" Go
autocmd FileType go setlocal noexpandtab

" Yaml
autocmd FileType yaml setlocal shiftwidth=2 textwidth=0 softtabstop=2

" Clang code-completion support. This is somewhat experimental!

" A path to a clang executable.
let g:clang_path = "clang++"

" A list of options to add to the clang commandline, for example to add
" include paths, predefined macros, and language options.
let g:clang_opts = [
  \ "-x","c++",
  \ "-D__STDC_LIMIT_MACROS=1","-D__STDC_CONSTANT_MACROS=1",
  \ "-Iinclude" ]

function! ClangComplete(findstart, base)
   if a:findstart == 1
      " In findstart mode, look for the beginning of the current identifier.
      let l:line = getline('.')
      let l:start = col('.') - 1
      while l:start > 0 && l:line[l:start - 1] =~ '\i'
         let l:start -= 1
      endwhile
      return l:start
   endif

   " Get the current line and column numbers.
   let l:l = line('.')
   let l:c = col('.')

   " Build a clang commandline to do code completion on stdin.
   let l:the_command = shellescape(g:clang_path) .
                     \ " -cc1 -code-completion-at=-:" . l:l . ":" . l:c
   for l:opt in g:clang_opts
      let l:the_command .= " " . shellescape(l:opt)
   endfor

   " Copy the contents of the current buffer into a string for stdin.
   " TODO: The extra space at the end is for working around clang's
   " apparent inability to do code completion at the very end of the
   " input.
   " TODO: Is it better to feed clang the entire file instead of truncating
   " it at the current line?
   let l:process_input = join(getline(1, l:l), "\n") . " "

   " Run it!
   let l:input_lines = split(system(l:the_command, l:process_input), "\n")

   " Parse the output.
   for l:input_line in l:input_lines
      " Vim's substring operator is annoyingly inconsistent with python's.
      if l:input_line[:11] == 'COMPLETION: '
         let l:value = l:input_line[12:]

        " Chop off anything after " : ", if present, and move it to the menu.
        let l:menu = ""
        let l:spacecolonspace = stridx(l:value, " : ")
        if l:spacecolonspace != -1
           let l:menu = l:value[l:spacecolonspace+3:]
           let l:value = l:value[:l:spacecolonspace-1]
        endif

        " Chop off " (Hidden)", if present, and move it to the menu.
        let l:hidden = stridx(l:value, " (Hidden)")
        if l:hidden != -1
           let l:menu .= " (Hidden)"
           let l:value = l:value[:l:hidden-1]
        endif

        " Handle "Pattern". TODO: Make clang less weird.
        if l:value == "Pattern"
           let l:value = l:menu
           let l:pound = stridx(l:value, "#")
           " Truncate the at the first [#, <#, or {#.
           if l:pound != -1
              let l:value = l:value[:l:pound-2]
           endif
        endif

         " Filter out results which don't match the base string.
         if a:base != ""
            if l:value[:strlen(a:base)-1] != a:base
               continue
            end
         endif

        " TODO: Don't dump the raw input into info, though it's nice for now.
        " TODO: The kind string?
        let l:item = {
          \ "word": l:value,
          \ "menu": l:menu,
          \ "info": l:input_line,
          \ "dup": 1 }

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      elseif l:input_line[:9] == "OVERLOAD: "
         " An overload candidate. Use a crazy hack to get vim to
         " display the results. TODO: Make this better.
         let l:value = l:input_line[10:]
         let l:item = {
           \ "word": " ",
           \ "menu": l:value,
           \ "info": l:input_line,
           \ "dup": 1}

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      endif
   endfor


   return []
endfunction ClangComplete

" This to enables the somewhat-experimental clang-based
" autocompletion support.
autocmd FileType c setlocal omnifunc=ClangComplete


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
au BufNewFile,BufRead *.sls setf yaml

" ====================
" Plugin configuration
" ====================

" Command-T/CTRL-P

noremap <leader>t <Esc>:CtrlP<CR>
noremap <leader>T <Esc>:CtrlPClearAllCaches<CR>
noremap <leader>m <Esc>:CtrlPBuffer<CR>
noremap <leader>js %!python -m json.tool<CR>
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

" Closetag

autocmd FileType html,htmldjango,jinjahtml,eruby,mako,jinja,jinja.html let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
let g:closetag_html_style=1

" Haskellmode
let g:haddock_browser="/usr/bin/google-chrome"
au BufEnter *.hs compiler ghc

" Pathogen initialization

call pathogen#infect()
call pathogen#helptags()

" SuperTab

let g:SuperTabDefaultCompletionType = "context"

set t_Co=16

" Solarized (colorscheme)

" let g:solarized_termcolors=256
colorscheme solarized

" Powerline, use cool fonts
let g:Powerline_symbols = 'fancy'

" Netrw hist
let g:netrw_home = "/tmp"
let g:netrw_list_hide = '.*\.py[co]$'

" ToggleBG
call togglebg#map("<F5>")

" Don't mess with vim-coffee-script
let g:syntastic_disabled_filetypes = ['coffee']

" =============
" Personal crap
" =============

" Append my own bin/ to the vim internal $PATH
let $PATH=$PATH . ":~/Applications/bin"

" Fish fix
set shell=/bin/bash

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

" Better clipping
vnoremap "+y :!xclip -f -sel clip<CR>
noremap "+p :r!xclip -o -sel clip<CR>

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

" no automatic template insertion
let g:templates_no_autocmd = 1

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
