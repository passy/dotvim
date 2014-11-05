call plug#begin()

" I don't even know what I'd do without tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'

Plug 'kana/vim-smartinput'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'scrooloose/syntastic'
Plug 'benmills/vimux'
Plug 'kien/ctrlp.vim'
Plug 'chreekat/vim-paren-crosshairs'
Plug 'altercation/vim-colors-solarized'
Plug 'Shougo/vimproc'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/powerline'
Plug 'itchyny/lightline.vim'

" Language specific stuff
Plug 'lukerandall/haskellmode-vim', { 'for': 'haskell' }
Plug 'dan-t/vim-hdevtools', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Shougo/neocomplcache.vim', { 'for': 'haskell' }
Plug 'dan-t/vim-hsimport', { 'for': 'haskell' }

call plug#end()
