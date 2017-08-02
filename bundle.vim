"dein Scripts-----------------------------

" Required:
set runtimepath^=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/bundle'))

call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-sleuth')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-markdown')
call dein#add('tpope/vim-surround')

call dein#add('kana/vim-smartinput')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-indent')
call dein#add('scrooloose/syntastic')
call dein#add('benmills/vimux')
call dein#add('chreekat/vim-paren-crosshairs')
call dein#add('altercation/vim-colors-solarized')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('Lokaltog/powerline')
call dein#add('itchyny/lightline.vim')
call dein#add('Raimondi/delimitMate')
call dein#add('godlygeek/tabular')
" Handy shortcuts and text motions for dealing with merge conflicts.
call dein#add('vim-scripts/ConflictMotions')
" Implicit dependency of the previous.
call dein#add('vim-scripts/CountJump')

" Neovim-specific
call dein#add('benekastah/neomake')
call dein#add('Shougo/deoplete.nvim')

" Can't language-detect this, because it contains the ftdetect rules
call dein#add('raichoo/purescript-vim')
call dein#add('lambdatoast/elm.vim')
call dein#add('tfnico/vim-gradle')

" Dep for async stuff done by other plugins.
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" Language specific stuff
call dein#add('yogsototh/haskell-vim', { 'on_ft': 'haskell' })
call dein#add('eagletmt/neco-ghc', { 'on_ft': 'haskell' })
call dein#add('eagletmt/ghcmod-vim', { 'on_ft': 'haskell' })
call dein#add('Shougo/neocomplcache.vim', { 'on_ft': 'haskell' })

call dein#add('ferreum/vim-fish', { 'on_ft': 'fish' })
call dein#add('cespare/vim-toml', { 'on_ft': 'toml' })
call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })
call dein#add('kchmck/vim-coffee-script', { 'on_ft': 'coffee' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
