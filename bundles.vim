" let Vundle manage Vundle
" required! 
" Plug 'gmarik/vundle' "This does not work yet with submodules

call plug#begin('~/.vim/plugged')

" original repos on github
Plug 'vim-scripts/L9'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/Tabular'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kien/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'sheerun/vim-polyglot'
Plug 'pix/vim-align'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'sickill/vim-pasta'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-tbone'
Plug 'wzzrd/vim-matchit'
Plug 'nelstrom/vim-visual-star-search'
Plug 'sjl/splice.vim'
Plug 'sjl/vitality.vim'
Plug 'vim-scripts/LanguageTool'
Plug 'vim-scripts/sudo.vim'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'jremmen/vim-ripgrep'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

"JAVASCRIPT
Plug 'moll/vim-node'
Plug 'heavenshell/vim-jsdoc'
Plug 'kristijanhusak/vim-js-file-import'

"REACT
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"ELM
Plug 'elmcast/elm-vim'

"AUTOCOMPLETE
"Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'sirver/ultisnips'
"
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

"SYNTAX

"COLORSCHEMES
Plug 'vim-scripts/Lucius'
Plug 'chriskempson/base16-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'jacoborus/tender.vim'

"Experimental
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-vinegar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'talek/obvious-resize'
Plug 'bling/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-peekaboo'
Plug 'guns/vim-sexp'
Plug 'unblevable/quick-scope'

Plug 'mileszs/ack.vim'
Plug 'ludovicchabant/vim-gutentags'

Plug 'thiagoalessio/rainbow_levels.vim'

"Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'tpope/vim-dispatch', { 'for': 'clojure' }

Plug 'Shougo/vimproc.vim', {'do' : 'make'}


" BUNDLES ARCHIVE {{{
"Plug 'ryanoasis/vim-devicons'
"  Plug 'ervandew/supertab'
"  Plug 'kana/vim-smartinput'
"  Plug 'ervandew/supertab'
"  Plug 'vim-stylus'
"  Plug 'css_color.vim'
"  Plug 'git://git.wincent.com/command-t.git'
"  Plug 'c9s/cascading.vim'
"  Plug 'juvenn/mustache.vim'
"  Plug 'comment.vim'
"  Plug 'kien/rainbow_parentheses.vim'
"  Plug 'Lokaltog/vim-powerline'
"  Plug 'YankRing.vim'  This currently completly broken c-p does not work,
"Plug 'AutoTag'
"Plug 'The-NERD-tree'
"Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plug 'tpope/vim-cucumber'
"Plug 'tpope/vim-pathogen'
"Plug 'tpope/vim-rails'
"Plug 'tpope/vim-rake'
"Plug 'vlmonk/vim-rspec'
"Plug 'ZoomWin'
"Plug 'Gist.vim'
"Plug 'stephpy/vim-php-cs-fixer'
"Plug 'chreekat/vim-paren-crosshairs'
"Plug 'ecomba/vim-ruby-refactoring'
"Plug 'vim-scripts/Tag-Signature-Balloons'
"Plug ahayman/vim-nodejs-complete 
"Plug 'venantius/vim-eastwood'
"Plug 'wellle/tmux-complete.vim'
"Plug 'gavinbeatty/dragvisuals.vim'
"Plug 'tpope/vim-haml'
"Plug 'honza/vim-snippets'
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neocomplete'
"Plug 'rstacruz/vim-ultisnips-css'
"Plug '2072/PHP-Indenting-for-VIm'
"Plug 'vim-scripts/VimClojure', { 'for': 'clojure' }
"Typescript
"Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
"Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
"Plug 'clausreinke/typescript-tools.vim'

"  overwrites @...
" }}}

call plug#end()
