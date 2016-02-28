call plug#begin()

" I don't even know what I'd do without tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'

Plug 'kana/vim-smartinput'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'scrooloose/syntastic'
Plug 'benmills/vimux'
Plug 'chreekat/vim-paren-crosshairs'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/powerline'
Plug 'itchyny/lightline.vim'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'

" Neovim-specific
Plug 'benekastah/neomake'

" Can't language-detect this, because it contains the ftdetect rules
Plug 'raichoo/purescript-vim'
Plug 'lambdatoast/elm.vim'
Plug 'tfnico/vim-gradle'

" Language specific stuff
Plug 'yogsototh/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'Shougo/neocomplcache.vim', { 'for': 'haskell' }
Plug 'Shougo/neocomplete.vim', { 'for': 'haskell' }

Plug 'ferreum/vim-fish', { 'for': 'fish' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
