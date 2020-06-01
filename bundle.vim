"dein Scripts-----------------------------

set runtimepath^=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/bundle')
  call dein#begin('~/.config/nvim/bundle')
    call dein#add('~/.config/nvim/bundle')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-sleuth')
    call dein#add('tpope/vim-unimpaired')
    call dein#add('tpope/vim-markdown')
    call dein#add('tpope/vim-surround')

    call dein#add('junegunn/fzf')

    call dein#add('kana/vim-smartinput')
    call dein#add('kana/vim-textobj-user')
    call dein#add('kana/vim-textobj-indent')
    call dein#add('benmills/vimux')
    call dein#add('chreekat/vim-paren-crosshairs')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('Lokaltog/powerline')
    call dein#add('itchyny/lightline.vim')
    call dein#add('Raimondi/delimitMate')
    call dein#add('godlygeek/tabular')
    " Only for the smart paste option, really
    call dein#add('wincent/terminus')
    " Handy shortcuts and text motions for dealing with merge conflicts.
    call dein#add('vim-scripts/ConflictMotions')
    " Implicit dependency of the previous.
    call dein#add('vim-scripts/CountJump')
    " Jump, jump, jump, jump around!
    call dein#add('easymotion/vim-easymotion')
    " Licenses
    call dein#add('antoyo/vim-licenses')

    " Tmux integrations
    call dein#add('wellle/tmux-complete.vim')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('roxma/vim-tmux-clipboard')

    " Neovim-specific
    call dein#add('w0rp/ale.git')
    call dein#add('roxma/nvim-yarp')
    call dein#add('ncm2/ncm2')
    call dein#add('ncm2/ncm2-tmux')
    call dein#add('ncm2/ncm2-github')
    call dein#add('ncm2/ncm2-path')
    call dein#add('ncm2/ncm2-bufword')
    " call dein#add('mhartington/nvim-typescript')

    " Typescript highlighting
    call dein#add('HerringtonDarkholme/yats.vim')

    " Can't language-detect this, because it contains the ftdetect rules
    call dein#add('raichoo/purescript-vim')
    call dein#add('lambdatoast/elm.vim')
    call dein#add('tfnico/vim-gradle')

    " Dep for async stuff done by other plugins.
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    " Language server
    " call dein#add('autozimu/LanguageClient-neovim')

    " Language specific stuff
    call dein#add('yogsototh/haskell-vim', { 'on_ft': 'haskell' })
    call dein#add('eagletmt/neco-ghc', { 'on_ft': 'haskell' })
    call dein#add('parsonsmatt/intero-neovim', { 'on_ft': 'haskell' })
    call dein#add('Shougo/neocomplcache.vim', { 'on_ft': 'haskell' })
    call dein#add('flowtype/vim-flow', { 'on_ft': 'javascript' })

    call dein#add('ferreum/vim-fish', { 'on_ft': 'fish' })
    call dein#add('cespare/vim-toml', { 'on_ft': 'toml' })
    call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })
    call dein#add('kchmck/vim-coffee-script', { 'on_ft': 'coffee' })
    call dein#add('vmchale/dhall-vim', { 'on_ft': 'dhall' })

  call dein#end()
  call dein#save_state()
endif

"End dein Scripts-------------------------
